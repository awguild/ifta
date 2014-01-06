'use strict';

angular.module('schedulerApp')
    .directive('room', function(){
        return {
            scope: {
                room: '='
            },
            templateUrl: '/assets/scheduler/views/rooms/form.html'
        };
    });