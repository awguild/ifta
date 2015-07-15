angular.module('schedulerApp')
.factory('Slot', function($resource, Config){
  return $resource('/api/v1/conferences/:conference_year/slots/:id',
    {
        conference_year: Config.conferenceYear,
        id: "@id"
    },
    {
        update: {method: 'PATCH'}
    }
  );
});