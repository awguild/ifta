'use strict';

angular.module('schedulerApp', ['ngResource', 'ngRoute'])
.config(['$routeProvider', '$locationProvider',
function($routeProvider, $locationProvider){
   $routeProvider
   .when('/', {
      templateUrl: 'schedule.html',
      controller: 'ScheduleCtrl'
   })
   .when('/rooms', {
        templateUrl: 'rooms.html',
        controller: 'RoomsCtrl'
    })
   .when('/time_blocks', {
        templateUrl: 'time_blocks.html',
        controller: 'TimeBlocksCtrl'
    })
   .otherwise({
      redirectTo: '/'
    })
}]);
