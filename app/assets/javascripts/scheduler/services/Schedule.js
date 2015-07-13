angular.module('schedulerApp')
.factory('Schedule', ['$http', 'Config',
function($http, Config){
  var url = '/api/v1/conferences/' +  encodeURIComponent(Config.conferenceYear) + '/schedule';

  function fetch(){
   return $http.get(url);
  }

  return {
    fetch: fetch
  }
}]);