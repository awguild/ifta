'use strict';

angular.module('schedulerApp')

.factory('Room', ['$resource', 'Config', function($resource, Config){
  return $resource('/api/v1/conferences/:conference_year/rooms/:id',
    {
        conference_year: Config.conference_year,
        id: "@id"
    },
    {
        update: {method: 'PUT'}
    }
  );
}]);