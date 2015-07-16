angular.module('schedulerApp')
.factory('Slots', ['$http', 'Config',
function($http, Config){
  var url = '/api/v1/conferences/' +  encodeURIComponent(Config.conference_year) + '/slots';

  function bulkCreate(params){
   return $http.post(url, params);
  }

  return {
    bulkCreate: bulkCreate
  }
}]);
