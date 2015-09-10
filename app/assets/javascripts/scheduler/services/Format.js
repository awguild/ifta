angular.module('schedulerApp')
.service('Format', [
  'Config',
  '$http',
function(Config, $http){
  var URL = '/api/v1/conferences/' +  encodeURIComponent(Config.conference_year) + '/proposals/formats';

  function fetch(){
    return $http.get(URL)
  }

  return {
    fetch: fetch
  }
}])
