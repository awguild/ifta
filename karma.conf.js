module.exports = function(config) {
  'use strict';

  config.set({
    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,

    // base path, that will be used to resolve files and exclude
    basePath: '../',

    // testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['jasmine'],

    // list of files / patterns to load in the browser
    files: [
      // bower:js
      'http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.4.2/angular.min.js',
      'http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.4.2/angular-resource.min.js',
      'http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.4.2/angular-route.min.js',
      'http://cdnjs.cloudflare.com/ajax/libs/angular.js/1.4.2/angular-mocks.js',
      'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js',
      // endbower
      'ifta/app/assets/javascripts/scheduler/**/*.js',
      'ifta/scheduler_specs/mocks.js',
      'ifta/scheduler_specs/**/*.js',
    ],

    // list of files / patterns to exclude
    exclude: [
    ],

    // web server port
    port: 9000,

    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: [
      'PhantomJS'
    ],

    // Which plugins to enable
    plugins: [
      'karma-phantomjs-launcher',
      'karma-jasmine'
    ],

    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false,

    colors: true,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO,

    // Uncomment the following lines if you are using grunt's server to run the tests
    // proxies: {
    //   '/': 'http://localhost:9000/'
    // },
    // URL root prevent conflicts with the site root
    // urlRoot: '_karma_'
  });
};
