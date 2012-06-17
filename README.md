mucus
=====

Chrome extension 


Install Build Requirements
--------------------------

* `bundle install`

* `brewdle install` to have [brewdler](https://github.com/andrew/brewdler) install required
packages via [homebrew](https://github.com/mxcl/homebrew). Otherwise, ensure you have installed
all the files in Brewfile.

Rake Options
------------

`rake` - Alias for `rake build:minified`.

`rake build` - Build the extension.

`rake build:minified` - Build the extension and minify CSS, JS and images.

`rake build:doc` - Builds the documentation to /doc.
