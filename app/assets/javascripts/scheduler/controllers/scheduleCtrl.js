angular.module('schedulerApp')
.controller('ScheduleCtrl', ['Config', 'Schedule', 'Slots',
function(Config, Schedule, Slots){
  var self = this;
  this.Config = Config;

  this.createSlots = function createSlots(params){
    Slots.bulkCreate(params)
    .then(function(res){
      // todo smarter push logic, merge if existing block
      self.time_blocks.push(res.data)
    })
  }
}]);