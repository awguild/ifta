'use strict';

angular.module('schedulerApp')
/*
 * Controls
 *
 */
.controller('RoomsCtrl', ["Room",
function(Room){
  this.rooms = Room.query(function(data){
    console.log('success with', data)
  });


  this.room = new Room();
  this.createRoom = function createRoom(room){
    room.$save();
    this.rooms.push(room);
    this.room = new Room();
  }
}]);