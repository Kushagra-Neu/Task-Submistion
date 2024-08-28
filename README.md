# Project Overview

This project is organized into several key files and directories, each serving a specific purpose in the development, deployment, and operation of the Flask-based REST API service.

## File and Directory Structure

### 1. `app.py`

**Purpose**: Contains the main implementation of the Flask application. This file:

- Defines the Flask application and its routes.
- Implements the logic for the API endpoints (`/`, `/health`, `/v1/tools/lookup`, `/v1/tools/validate`, `/v1/history`).
- Includes utility functions for DNS resolution and IP validation.
- Initializes the PostgreSQL database and handles database interactions for storing query history.
- Sets up Prometheus monitoring.

### 2. `requirements.txt`

**Purpose**: Lists the Python dependencies required for the Flask application. This file is used by Docker to install the necessary packages.

### 3. `Dockerfile`

**Purpose**: Defines the instructions for building the Docker image of the Flask application. Key points include:

- Using the official Python image as the base.
- Installing dependencies from `requirements.txt`.
- Copying the application code into the container.
- Running the Flask application.

### 4. `docker-compose.yml`

**Purpose**: Configures and manages multi-container Docker applications. This file defines:

- The `web` service for the Flask application, including build settings, environment variables, and port mappings.
- The `db` service for PostgreSQL, specifying the image, environment variables for database setup, and network configuration.

### 5. `helm/my-app/Chart.yaml`

**Purpose**: Provides metadata about the Helm chart. This file includes:

- The name, description, version, and application version of the Helm chart.

### 6. `helm/my-app/values.yaml`

**Purpose**: Defines the default configuration values for the Helm chart. Key settings include:

- The Docker image repository and tag.
- The type and port of the Kubernetes service.
- Database connection settings (managed as secrets).

### 7. `helm/my-app/templates/secret.yaml`

**Purpose**: Creates Kubernetes secrets for sensitive data such as database credentials. This file ensures that sensitive information is not exposed in the Helm chart.

### 8. `helm/my-app/templates/deployment.yaml`

**Purpose**: Defines the Kubernetes Deployment for the Flask application. This file includes:

- The number of replicas.
- The Docker image to use.
- Environment variables, including database credentials from secrets.

### 9. `helm/my-app/templates/service.yaml`

**Purpose**: Configures the Kubernetes Service for the Flask application. This file specifies:

- The service type (`ClusterIP`) and port settings.
- How to route traffic to the Flask application.

### 10. `.github/workflows/ci.yml`

**Purpose**: Configures the GitHub Actions CI pipeline. This file automates:

- Code linting using `flake8`.
- Building and pushing the Docker image.
- Packaging the Helm chart.
- Uploading the Helm chart artifact.

### 11. `README.md`

**Purpose**: Provides documentation for the project. It includes:

- An overview of the project's features and functionality.
- Instructions for running the application locally and deploying it to Kubernetes.
- Details on file and directory structure, configuration, and CI pipeline.
