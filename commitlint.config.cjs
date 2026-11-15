module.exports = {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "subject-case": [0], // allow any casing in the subject
    "header-max-length": [2, "always", 100],
  },
};
