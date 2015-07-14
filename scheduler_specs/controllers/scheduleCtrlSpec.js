describe('ScheduleCtrl', function(){
  beforeEach(module('schedulerApp'));

  beforeEach(module(function($provide){
    $provide.value('Config', {conferenceYear: '2015'});
  }));

  var scheduleCtrl, Config, $scope, $q, $httpBackend, Slot;
  beforeEach(inject(function($rootScope, $controller, $injector, _$q_, _Config_, _Slot_){
    Config = _Config_;
    Slot = _Slot_;
    $q = _$q_;

    $httpBackend = $injector.get('$httpBackend');
    $httpBackend.whenGET('/api/v1/conferences/2015/schedule')
    .respond(200, "[]")
    $httpBackend.whenGET('/api/v1/conferences/2016/schedule')
    .respond(500, "[]")

    $scope = $rootScope.$new();
    scheduleCtrl = $controller('ScheduleCtrl', { $scope: $scope});
  }));

  it('should make Config available', function(){
    expect(scheduleCtrl.Config).toEqual(Config)
  });


  describe('Schedule.fetch', function(){
    it('should have fetched the schedule and assigned it', function(){
      $httpBackend.flush();
      $httpBackend.verifyNoOutstandingExpectation();
      $httpBackend.verifyNoOutstandingRequest();

      expect(scheduleCtrl.time_blocks).toEqual([]);
    });
  });

  describe('updateSlot', function(){
    it('should update the slot', function(){
      var params = {id: 3, proposal_id: 7}
        , deffered = $q.defer();

      spyOn(Slot, 'update').and.returnValue(deffered.promise)
      scheduleCtrl.updateSlot(params)
      expect(Slot.update).toHaveBeenCalledWith({id: 3}, params);
    });

    it('should add an errorMessage when unable to update the slot', function(){
      var params = {id: 3, proposal_id: 7}
        , deffered = $q.defer();

      spyOn(Slot, 'update').and.returnValue(deffered.promise);
      scheduleCtrl.updateSlot(params);
      deffered.reject('error');
      $scope.$digest();

      expect(scheduleCtrl.errorMessage).not.toBe(null);
    });
  });
});