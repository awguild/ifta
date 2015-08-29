angular.module('schedulerApp')
.service('Format', ['$http', function($http){
  var URL = '/api/v1/proposals/formats'

  function fetch(){
    return $http.get(URL)
  }

  return {
    fetch: fetch
  }
}])
