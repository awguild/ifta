angular.module('schedulerApp')
.factory('Proposals', ['$http', 'Config',
function($http, Config){
  var url = '/api/v1/conferences/' +  encodeURIComponent(Config.conferenceYear) + '/proposals/search';

  function fetch(){
   return $http.get(url);
  }

  return {
    fetch: fetch
  }
}]);