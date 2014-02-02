'use strict';

var schedulerApp = angular.module('schedulerApp', ['ngResource', 'ngRoute']);
schedulerApp.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider){
   $routeProvider.when('/rooms', {
        templateUrl: '/assets/scheduler/views/rooms/edit.html', 
        controller: 'RoomsCtrl' 
    })
   .otherwise({
        redirectTo: '/presentations'
    });
}]);