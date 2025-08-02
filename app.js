const express = require('express');
const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
    res.json({
        message: 'Hello from OpenShift Docker Build!',
        version: '1.0.0',
        timestamp: new Date().toISOString(),
        pod: process.env.HOSTNAME || 'unknown',
        environment: process.env.NODE_ENV || 'development'
    });
});

app.get('/health', (req, res) => {
    res.status(200).json({ 
        status: 'healthy',
        uptime: process.uptime(),
        memory: process.memoryUsage()
    });
});

app.get('/api/info', (req, res) => {
    res.json({
        service: 'Docker Build Demo',
        build_strategy: 'Docker',
        platform: 'OpenShift 4.16'
    });
});

app.listen(port, '0.0.0.0', () => {
    console.log(`🚀 Server running on port ${port}`);
    console.log(`📊 Health check available at /health`);
    console.log(`ℹ️  Info endpoint available at /api/info`);
});
