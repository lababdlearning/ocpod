# OpenShift Docker Build Demo

A simple Node.js application demonstrating Docker build strategy in OpenShift 4.16.

## Features
- Express.js web server
- Health check endpoint
- Info API endpoint
- OpenShift-ready Docker configuration

## Endpoints
- `/` - Main application info
- `/health` - Health check
- `/api/info` - Service information

## OpenShift Deployment

Deploy directly from Git repository:
\`\`\`bash
oc new-app https://github.com/lababdlearning/ocpod.git --strategy=docker --name=docker-demo
\`\`\`

## Local Development
\`\`\`bash
npm install
npm start
\`\`\`

Access at: http://localhost:8080
