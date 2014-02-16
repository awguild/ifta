'use strict';

var roomsCtrl = angular.module('schedulerApp');

roomsCtrl.controller('RoomsCtrl', ["$scope", "$location", "$routeParams", "RoomsService", function($scope, $location, $routeParams, RoomsService){
    var binary_options = [{name: 'Yes'}, {name: 'No'}]
    this.rooms = RoomsService.query({conference_id: 1});
    this.audio_options = binary_options;
    this.video_options = binary_options;
}]);