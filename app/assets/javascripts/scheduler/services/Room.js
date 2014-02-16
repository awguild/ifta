'use strict';

var roomService = angular.module('schedulerApp');

roomService.factory('RoomsService', function($resource){
    return $resource('/conferences/:conference_id/rooms/:id.json',
        {
            conference_id: "@conference_id",
            id: "@id"
        },
        {
            update: {method: 'PUT'}
        }
    );
});