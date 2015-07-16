angular.module('schedulerApp')
.factory('Slot', ['$resource', 'Config', function($resource, Config){
  return $resource('/api/v1/conferences/:conference_year/slots/:id',
    {
        conference_year: Config.conference_year,
        id: "@id"
    },
    {
        update: {method: 'PATCH'}
    }
  );
}]);