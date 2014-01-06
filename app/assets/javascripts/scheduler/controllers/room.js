'use strict';

var roomsCtrl = angular.module('schedulerApp');

roomsCtrl.controller('RoomsCtrl', ["$scope", "$location", "RoomsService", function($scope, $location, RoomsService){
    this.rooms = RoomsService.query({conference_id: 1});
}])