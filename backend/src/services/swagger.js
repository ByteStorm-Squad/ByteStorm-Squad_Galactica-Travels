const swaggerJSDocs = require('swagger-jsdoc')

const options = {
    definition: {
        openapi: '3.0.0',
        info: {
            title: 'Galactic Travels Backend API',
            version: '1.0.0',
            description: 'The NodeJS Express API for Galactic Travels',
        },
        servers: [
            {
                url: "http://localhost:8080/",
                description: "Local server"
            }
        ]
    },
    apis: ["./src/docs/*.yaml"]  //Routes locations for JSDoc matcher. Should start from root folder
}

const swaggerSpecs = swaggerJSDocs(options)

module.exports = {
    swaggerSpecs
}
