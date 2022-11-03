const fs = require("fs");

const SEVMAP = {
    "INFO": 1,
    "LOW": 2,
    "MEDIUM": 5,
    "HIGH": 7
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
let data = JSON.parse(fileContents);

let flattened = data.queries.flatMap((item) => {
    return item.files.map((f) => ({
        issueName: item.query_name,
        issueDescription: item.description,
        scanTool: "Checkmarx KICS",
        severity: SEVMAP[item.severity] ? SEVMAP[item.severity] : 0,
        libraryName: item.platform,

        issueType: item.category,
        fileName: f.file_name,
        lineNumber: f.line,
        remediationSteps: "Expected Value: \n" + f.expected_value + "\n\nActual Value:\n" + f.actual_value + "\n\n More info: " + item.query_url,
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

fs.writeFileSync(outputFile, JSON.stringify(result, null, " "))