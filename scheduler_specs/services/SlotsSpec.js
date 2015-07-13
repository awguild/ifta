describe('Slots', function(){
  beforeEach(module('schedulerApp'));

  beforeEach(module(function($provide){
    $provide.value('Config', {conferenceYear: '2015'});
  }));

  var Slots, $httpBackend;
  beforeEach(inject(function(_Slots_, $injector){
    Slots = _Slots_;
    $httpBackend = $injector.get('$httpBackend');
    $httpBackend.whenPOST('/api/v1/conferences/2015/slots', {quantity: 3})
    .respond(201, "[]");
  }));

  it('should create the time blocks and slots for the 2015 schedule', function(){
    var slots = Slots.bulkCreate({quantity: 3})
    $httpBackend.flush();
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });
});