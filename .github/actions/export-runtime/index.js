const fs = require("fs");
const variables = [
  `ACTIONS_RUNTIME_TOKEN=${process.env.ACTIONS_RUNTIME_TOKEN}`,
  `ACTIONS_CACHE_URL=${process.env.ACTIONS_CACHE_URL}`,
];

let env = fs.readFileSync(process.env.GITHUB_ENV).toString();
env += variables.join("\n") + "\n";
fs.writeFileSync(process.env.GITHUB_ENV, env);
