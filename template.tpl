{
  "name": "CookiePrime CMP",
  "description": "Cookie Consent Management Platform by CookiePrime - Google CMP Partner",
  "logo": "https://cookieprime.com/logo.png",
  "categories": ["ANALYTICS", "TAG_MANAGEMENT", "ADVERTISING"],
  "permissions": [
    {
      "name": "inject_script",
      "allowedUrls": [
        "https://storage.googleapis.com/cookieprime_bucket/*"
      ]
    },
    {
      "name": "get_url",
      "allowedUrls": [
        "https://storage.googleapis.com/cookieprime_bucket/*",
        "https://cookieprime.com/*"
      ]
    },
    {
      "name": "send_xhr",
      "allowedUrls": [
        "https://consent-storage-service-*.run.app/api/*",
        "https://cookieprime.com/api/*"
      ]
    },
    {
      "name": "set_consent_state",
      "consentType": ["ad_storage", "analytics_storage", "ad_user_data", "ad_personalization"]
    },
    {
      "name": "log"
    },
    {
      "name": "access_global_window",
      "keys": [
        "_cookiePrimeConfig"
      ]
    },
    {
      "name": "write_global_window",
      "keys": [
        "_cookiePrimeConfig"
      ]
    }
  ],
  "fields": [
    {
      "name": "apiKey",
      "displayName": "Site ID / API Key",
      "type": "TEXT",
      "valueHint": "your-domain-api-key",
      "required": true
    },
    {
      "name": "theme",
      "displayName": "Banner Theme",
      "type": "SELECT",
      "options": [
        {"displayValue": "Theme 1", "value": "1"},
        {"displayValue": "Theme 2 (Coca-Cola)", "value": "2"},
        {"displayValue": "Theme 3", "value": "3"},
        {"displayValue": "Theme 4 (Classic)", "value": "4"},
        {"displayValue": "Theme 5 (Modern)", "value": "5"},
        {"displayValue": "Theme 7 (Audi-style)", "value": "7"}
      ],
      "defaultValue": "5"
    },
    {
      "name": "devMode",
      "displayName": "Development Mode",
      "type": "CHECKBOX",
      "defaultValue": false,
      "helpText": "Enable for testing - bypasses domain verification"
    }
  ],
  "code": [
    "const injectScript = require('injectScript');",
    "const logToConsole = require('logToConsole');",
    "const setDefaultConsentState = require('setDefaultConsentState');",
    "const setInWindow = require('setInWindow');",
    "",
    "// ===========================================",
    "// CookiePrime CMP - Google Consent Mode v2",
    "// IAB TCF v2.2 Compliant - CMP ID: dMjJjND",
    "// ===========================================",
    "",
    "// Step 1: Set default consent mode",
    "setDefaultConsentState({",
    "  'ad_storage': 'denied',",
    "  'analytics_storage': 'denied',",
    "  'ad_user_data': 'denied',",
    "  'ad_personalization': 'denied',",
    "  'wait_for_update': 500",
    "});",
    "",
    "logToConsole('[CookiePrime] ✅ Default consent mode set via GTM API');",
    "",
    "// Step 2: Pass configuration to window object",
    "setInWindow('_cookiePrimeConfig', {",
    "  apiKey: data.apiKey,",
    "  theme: data.theme,",
    "  devMode: data.devMode || false,",
    "  gtmIntegration: true",
    "}, true);",
    "",
    "// Step 3: Inject the loader script",
    "const url = 'https://storage.googleapis.com/cookieprime_bucket/public/loader.js';",
    "",
    "injectScript(url,",
    "  function() {",
    "    logToConsole('[CookiePrime] ✅ Loader script injected successfully');",
    "    data.gtmOnSuccess();",
    "  },",
    "  function() {",
    "    logToConsole('[CookiePrime] ❌ Failed to inject loader script');",
    "    data.gtmOnFailure();",
    "  },",
    "  'cookieprime_loader'",
    ");"
  ]
}