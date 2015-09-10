angular.module('schedulerApp')
.factory('Presenters', ['$http', 'Config',
function($http, Config){
  var url = '/api/v1/conferences/' +  encodeURIComponent(Config.conference_year) + '/proposals/presenters';

  function fetch(){
   return $http.get(url);
  }

  return {
    fetch: fetch
  }
}]);