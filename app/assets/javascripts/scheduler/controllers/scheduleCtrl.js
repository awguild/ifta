angular.module('schedulerApp')
.controller('ScheduleCtrl', ['Config', 'Schedule', 'Slots', 'Slot',
function(Config, Schedule, Slots, Slot){
  var self = this;
  this.Config = Config;
  this.errorMessage = null;
  this.time_blocks = []

  /*
   * fetches an array with the full schedule structured like
   * time_blocks []
   *  slots []
   *    proposal {}
   *      user {}
   *        country {}
   *    room {}
   */
  Schedule.fetch()
  .then(function(res){
    self.time_blocks = res.data;
  }).catch(function(err){
    self.errorMessage = 'Unable to fetch the schedule.'
  });

  /* updates a single slot */
  this.updateSlot = function updateSlot(params){
    Slot.update({id: params.id}, params).catch(function(err){
      self.errorMessage = 'Unable to update slot.'
    })
  }
}]);