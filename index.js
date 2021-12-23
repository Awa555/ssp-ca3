const   http = require('http'), //This module provides the HTTP server functionalities
        path = require('path'), //The path module provides utilities for working with file and directory paths
        express = require('express'), //This module allows this app to respond to HTTP requests, defines the routing and renders back the required content
        fs = require('fs'), //This module allows to work with the file system: read and write files back
        xmlParse = require('xslt-processor').xmlParse, //This module allows to work with XML files
        xsltProcess = require('xslt-processor').xsltProcess, //The same module allows us to uitlise XSL Transformations
        xml2js = require('xml2js'); //This module does XML <-> JSON conversion

const   router = express(),  // Create an instance of express
        server = http.createServer(router); // Create an instance for the server to start running

router.use(express.static(path.resolve(__dirname,'views'))); // We serve static content from "views" folder

router.get('/get/html', function(req, res) { // Create an instance of the http server to handle HTTP requests

    res.writeHead(200, {'Content-Type' : 'text/html'}); // Set a response type of plain text. Tell browser that content is html

    let xml = fs.readFileSync('Frutea.xml', 'utf8'), // Read file
        xsl = fs.readFileSync('Frutea.xsl', 'utf8'); // Read file

    let doc = xmlParse(xml), // Return String to object
        stylesheet = xmlParse(xsl);

    let result = xsltProcess(doc, stylesheet); // Apply to transformation

    res.end(result.toString()); // Confirm back to String

});

// Allow the server listen to requiest and start the server on port 3000
server.listen(process.env.PORT || 3000, process.env.IP || "0.0.0.0", function() {
    const addr = server.address();
    console.log("Server listening at", addr.address + ":" + addr.port)
});