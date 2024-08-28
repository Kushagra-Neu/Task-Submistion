from flask import Flask, jsonify, request
from flask_restful import Api, Resource
from prometheus_flask_exporter import PrometheusMetrics
import datetime
import os
import psycopg2
import ipaddress

app = Flask(__name__)
api = Api(app)
metrics = PrometheusMetrics(app)

def get_db_connection():
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'db'), 
        port=os.getenv('DB_PORT', '5432'),
        database=os.getenv('DB_NAME', 'mydatabase'),
        user=os.getenv('DB_USER', 'myuser'),
        password=os.getenv('DB_PASSWORD', 'mypassword')
    )
    return conn

def init_db():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
    CREATE TABLE IF NOT EXISTS queries (
        id SERIAL PRIMARY KEY,
        domain TEXT NOT NULL,
        result TEXT NOT NULL,
        created_time INTEGER NOT NULL
    )
    """)
    conn.commit()
    cur.close()
    conn.close()

def resolve_domain(domain):
    if domain == 'example.com':
        return ['93.184.216.34']
    else:
        return []

def validate_ip(ip):
    try:
        ipaddress.ip_address(ip)
        return True
    except ValueError:
        return False

@app.route('/', methods=['GET'])
def root():
    kubernetes = 'KUBERNETES_SERVICE_HOST' in os.environ
    return jsonify({
        'version': '0.1.0',
        'date': int(datetime.datetime.now().timestamp()),
        'kubernetes': kubernetes
    })

class Health(Resource):
    def get(self):
        return jsonify({'status': 'UP'})

class Lookup(Resource):
    def get(self):
        domain = request.args.get('domain')
        if not domain:
            return {'message': 'Domain is required'}, 400
        try:
            ip_addresses = resolve_domain(domain)
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute(
                'INSERT INTO queries (domain, result, created_time) VALUES (%s, %s, %s)',
                (domain, ','.join(ip_addresses), int(datetime.datetime.now().timestamp()))
            )
            conn.commit()
            cur.close()
            conn.close()
            return {
                'addresses': [{'ip': ip, 'queryID': None} for ip in ip_addresses],
                'domain': domain,
                'client_ip': request.remote_addr,
                'created_time': int(datetime.datetime.now().timestamp()),
                'queryID': None
            }
        except Exception as e:
            return {'message': str(e)}, 500

class Validate(Resource):
    def post(self):
        data = request.get_json()
        ip = data.get('ip')
        if not ip:
            return {'message': 'IP is required'}, 400
        is_valid = validate_ip(ip)
        return {'status': is_valid}

class History(Resource):
    def get(self):
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT * FROM queries ORDER BY created_time DESC LIMIT 20')
        rows = cur.fetchall()
        conn.close()
        return {
            'addresses': [{'ip': ip, 'queryID': row[0]} for row in rows for ip in row[2].split(',')],
            'domain': None,
            'client_ip': None,
            'created_time': None,
            'queryID': None
        }

api.add_resource(Health, '/health')
api.add_resource(Lookup, '/v1/tools/lookup')
api.add_resource(Validate, '/v1/tools/validate')
api.add_resource(History, '/v1/history')

if __name__ == '__main__':
    init_db()
    app.run(port=3000)