'use strict';

angular.module('schedulerApp')
.directive('room', function(){
  return {
    scope: {room: '='},
    templateUrl: '/assets/scheduler/views/rooms/form.html',
    controller: function($scope){
      $scope.save = function(room){
        console.log('do something', room)
        room.$update();
      }
    }
  };
});