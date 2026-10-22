export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Messages en français : on n'impose pas la casse du sujet
    'subject-case': [0],
  },
};
