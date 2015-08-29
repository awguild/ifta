describe('Format', function(){
  var Format, $httpBackend
  beforeEach(inject(function(_Format_, $injector){
    Format = _Format_
    $httpBackend = $injector.get('$httpBackend')
    $httpBackend.whenGET('/api/v1/conferences/2015/proposals/formats')
    .respond(200)
  }))

  describe('fetch', function(){
    it('should fetch the formats for the conference', function(){
      Format.fetch()

      $httpBackend.flush()
      $httpBackend.verifyNoOutstandingRequest()
      $httpBackend.verifyNoOutstandingExpectation()
    })
  })
})
