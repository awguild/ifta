describe('Schedule', function(){
  beforeEach(module('schedulerApp'));

  beforeEach(module(function($provide){
    $provide.value('Config', {conference_year: '2015'});
  }));

  var Schedule, $httpBackend;
  beforeEach(inject(function(_Schedule_, $injector){
    Schedule = _Schedule_;
    $httpBackend = $injector.get('$httpBackend');
    $httpBackend.whenGET('/api/v1/conferences/2015/time_blocks')
    .respond(200, "[]");
  }));

  it('should fetch the 2015 schedules', function(){
    var schedules = Schedule.fetch()
    $httpBackend.flush();
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });
});