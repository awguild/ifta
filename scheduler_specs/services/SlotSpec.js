describe('Slot', function(){
  var Slot, $httpBackend;
  beforeEach(inject(function(_Slot_, $injector){
    Slot = _Slot_;
    $httpBackend = $injector.get('$httpBackend');
    $httpBackend.expectPATCH('/api/v1/conferences/2015/slots/7', {id: 7, proposal_id: 3, room_id: 5})
    .respond(200, "{}");
  }));

  it('should update the slot with any parameters on the slot', function(){
    var slot = {id: 7, proposal_id: 3, room_id: 5};
    Slot.update({id: slot.id}, slot);

    $httpBackend.flush();
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });
});
