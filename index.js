// Below of code has been sourced from the lecturer Mikhail Timofeev class teaching. https://github.com/mikhail-cct/ssp-practical

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
router.use(express.urlencoded({extended: true})); // We allow the data sent from the client to be encoded in a URL targeting our end point
router.use(express.json()); // We include support for JSON

// Function to read in XML file and convert it to JSON
function XMLtoJSON(filename, cb) {
    var filepath = path.normalize(path.join(__dirname, filename));
    fs.readFile(filepath, 'utf8', function(err, xmlStr) {
      if (err) throw (err);
      xml2js.parseString(xmlStr, {}, cb);
    });
};
  
// Function to convert JSON to XML and save it
function JSONtoXML(filename, obj, cb) {
    var filepath = path.normalize(path.join(__dirname, filename));
    var builder = new xml2js.Builder();
    var xml = builder.buildObject(obj);
    fs.unlinkSync(filepath);
    fs.writeFile(filepath, xml, cb);
};

router.get('/get/html', function(req, res) { // Create an instance of the http server to handle HTTP requests

    res.writeHead(200, {'Content-Type' : 'text/html'}); // Set a response type of plain text. Tell browser that content is html

    let xml = fs.readFileSync('Frutea.xml', 'utf8'), // Read file
        xsl = fs.readFileSync('Frutea.xsl', 'utf8'); // Read file

    let doc = xmlParse(xml), // Return String to object
        stylesheet = xmlParse(xsl);

    let result = xsltProcess(doc, stylesheet); // Apply to transformation

    res.end(result.toString()); // Confirm back to String

});

// Additional JSON
router.post('/post/json', function (req, res) {

    function appendJSON(obj) {

        console.log(obj)

        XMLtoJSON('Frutea.xml', function (err, result) {
            if (err) throw (err);
            
            result.menu.section[obj.sec_n].entry.push({'item': obj.item, 'price': obj.price}); // Add items

            console.log(JSON.stringify(result, null, "  "));

            JSONtoXML('Frutea.xml', result, function(err){
                if (err) console.log(err);
            });
        });
    };

    appendJSON(req.body);

    res.redirect('back');

});

// Delete JSON
router.post('/post/delete', function (req, res) {

    function deleteJSON(obj) {

        console.log(obj)

        XMLtoJSON('Frutea.xml', function (err, result) {
            if (err) throw (err);
            
            delete result.menu.section[obj.section].entry[obj.entree]; // Delete itmes

            console.log(JSON.stringify(result, null, "  "));

            JSONtoXML('Frutea.xml', result, function(err){
                if (err) console.log(err);
            });
        });
    };

    deleteJSON(req.body);

    res.redirect('back');

});

// Allow the server listen to requiest and start the server on port 3000
server.listen(process.env.PORT || 3000, process.env.IP || "0.0.0.0", function() {
    const addr = server.address();
    console.log("Server listening at", addr.address + ":" + addr.port)
});