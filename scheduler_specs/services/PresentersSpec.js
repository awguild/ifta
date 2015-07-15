describe('Presenters', function(){
  beforeEach(module('schedulerApp'));

  beforeEach(module(function($provide){
    $provide.value('Config', {conferenceYear: '2015'});
  }));

  var Presenters, $httpBackend;
  beforeEach(inject(function(_Presenters_, $injector){
    Presenters = _Presenters_;
    $httpBackend = $injector.get('$httpBackend');
    $httpBackend.whenGET('/api/v1/conferences/2015/proposals/presenters')
    .respond(200, "[]");
  }));

  it('should fetch the 2015 presenters', function(){
    var presenters = Presenters.fetch()
    $httpBackend.flush();
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });
});