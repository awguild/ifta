describe('ScheduleCtrl', function(){
  beforeEach(module('schedulerApp'));

  var scheduleCtrl, Config, $scope;
  beforeEach(inject(function($rootScope, $controller, _Config_){
    Config = _Config_;

    $scope = $rootScope.$new();
    scheduleCtrl = $controller('ScheduleCtrl', { $scope: $scope});
  }));

  it('should make Config available', function(){
    expect(scheduleCtrl.Config).toEqual(Config)
  });
});