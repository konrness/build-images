const fs = require("fs");

const SEVMAP = {
    "INFORMATIONAL": 0,
    "LOW": 2,
    "MEDIUM": 5.5,
    "HIGH": 7.9,
    "CRITICAL": 9.5
}

let args = process.argv.slice(2);
let inputFile = args[0];
let outputFile = args[1];
if (!inputFile || inputFile == "") {
    console.log("No input file specified");
    process.exit(-1)
}

if (!outputFile || outputFile == "") {
    console.log("No output file specified");
    process.exit(-1)
}

let fileContents = fs.readFileSync(inputFile).toString();
let matches = fileContents.match(/({"[\s\S]*})/);

// check if valid JSON
try {
    if (null === matches) {
        console.log(matches);
        throw "No JSON objects found.";
    }

    var data = JSON.parse(matches[0]);

    // validate proper format
    if (typeof data.result !== 'object') {
        throw "No data.result found in JSON";
    }
} catch (err) {
    console.error("Error parsing Input JSON file.", err);
    process.exit(-1);
}

let flattened = [];

// Parse osPackages
if (null != data.result.osPackages && data.result.osPackages.length > 0) {
    console.debug("Parsing osPackages");

    let osPackages = data.result.osPackages.flatMap((item) => {
        return item.vulnerabilities.map((v) => ({
            packageName: item.name,
            version: item.version,
            issueName: v.name,
            issueDescription: "osPackage",
            scanTool: "Wiz",
            scanSeverity: v.severity,
            severity: SEVMAP[v.severity] ? SEVMAP[v.severity] : 0,
            remediationSteps: `Fixed version: ${v.fixedVersion}`,
            url: v.source
        }));
    });

    console.debug(" - Found ", osPackages.length);
    
    flattened = flattened.concat(osPackages);
}

// Parse libraries
if (null != data.result.libraries && data.result.libraries.length > 0) {
    console.debug("Parsing libraries");

    let cpes = data.result.libraries.flatMap((item) => {
        return item.vulnerabilities.map((v) => ({
            packageName: item.name,
            version: item.version,
            issueName: v.name,
            issueDescription: "library",
            fileName: item.path,
            scanTool: "Wiz",
            scanSeverity: v.severity,
            severity: SEVMAP[v.severity] ? SEVMAP[v.severity] : 0,
            remediationSteps: `Fixed version: ${v.fixedVersion}`,
            url: v.source
        }));
    });

    console.debug(" - Found ", cpes.length);

    flattened = flattened.concat(cpes);
}

// Parse CPEs
if (null != data.result.cpes && data.result.cpes.length > 0) {
    console.debug("Parsing CPEs");

    let libraries = data.result.cpes.flatMap((item) => {
        return item.vulnerabilities.map((v) => ({
            packageName: item.name,
            version: item.version,
            issueName: v.name,
            issueDescription: "CPE",
            fileName: item.path,
            scanTool: "Wiz",
            scanSeverity: v.severity,
            severity: SEVMAP[v.severity] ? SEVMAP[v.severity] : 0,
            remediationSteps: `Fixed version: ${v.fixedVersion}`,
            url: v.source
        }));
    });

    console.debug(" - Found ", libraries.length);

    flattened = flattened.concat(libraries);
}

console.debug("Total count: ", flattened.length);

let result = {
    meta: {
        key: [
            "packageName"
        ],
        "subproduct": "Wiz"
    },
    issues: flattened
}

fs.writeFileSync(outputFile, JSON.stringify(result))