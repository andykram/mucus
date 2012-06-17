"name": "Mucus"
"version": "0.1"
"manifest_version": 2
"description": "Adds option to Use Current Location' in Google Maps."
"icons":
  "16":  "icon_16.png"
  "64":  "icon_64.png"
  "128": "icon_128.png"
"options": "options.html"
"permissions":
  "http//maps.google.com/*"
  "geolocation"
"content_scripts":
  "css": "mucus.css"
  "matches":
    "*://maps.google.com/*"
