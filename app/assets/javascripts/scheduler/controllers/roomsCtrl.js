'use strict';

angular.module('schedulerApp')
/*
 * Controls
 *
 */
.controller('RoomsCtrl', ["$scope", "$location", "$routeParams", "Room",
function($scope, $location, $routeParams, Room){
  $scope.rooms = Room.query();

  $scope.save = function(room){
    room.$update();
  }
}]);