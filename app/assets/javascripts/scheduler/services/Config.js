angular.module('schedulerApp')
.factory('Config', ['$window', function($window){
  var gon = $window.gon;

  var Config = {
    conference_year: gon.conference_year
  };

  return Config
}])