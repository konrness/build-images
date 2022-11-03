const fs = require("fs");

const SEVMAP = {
    "INFORMATIONAL": 0,
    "LOW": 2,
    "MEDIUM": 5.45,
    "HIGH": 7.95,
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
let data = JSON.parse(matches[0]);
let flattened = data.result.osPackages.flatMap((item) => {
    return item.vulnerabilities.map((v) => ({
        packageName: item.name,
        version: item.version,
        issueName: v.name,
        issueDescription: "",
        scanTool: "Wiz",
        severity: SEVMAP[v.severity] ? SEVMAP[v.severity] : 0,
        remediationSteps: `Fixed version: ${v.fixedVersion}`
    }));
});

let result = {
    meta: {
        key: [
            "issueName"
        ]
    },
    issues: flattened
}

fs.writeFileSync(outputFile, JSON.stringify(result))