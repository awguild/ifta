'use strict';

angular.module('schedulerApp')

.factory('Room', function($resource){
  var year = "2016"; //tood inject conference
  return $resource('/api/v1/conferences/:conference_year/rooms/:id',
    {
        conference_year: year,
        id: "@id"
    },
    {
        update: {method: 'PUT'}
    }
  );
});