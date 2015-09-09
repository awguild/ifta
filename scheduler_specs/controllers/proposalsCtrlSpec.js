describe('ProposalsCtrl', function(){
  beforeEach(module('schedulerApp'));

  beforeEach(module(function($provide){
    $provide.value('Config', {conference_year: '2015'});
  }));

  var $q, $scope, $window, proposalsCtrl, Proposals, deffered, Format;
  beforeEach(inject(function($rootScope, _$window_, _$q_, $controller, _Proposals_, _Format_){
    Proposals = _Proposals_;
    $window = _$window_;
    $q = _$q_;
    Format = _Format_;

    deffered = $q.defer();
    spyOn(Proposals, 'fetch').and.returnValue(deffered.promise);

    deffered2 = $q.defer();
    spyOn(Format, 'fetch').and.returnValue(deffered2.promise);

    $scope = $rootScope.$new();
    proposalsCtrl = $controller('ProposalsCtrl', { $scope: $scope});
  }));

  describe('fetch proposal', function(){
    it('should fetch proposals and set them on the controller', function(){
      var proposals = [{title: 'Teaching anti bullying.'}];
      deffered.resolve({data: proposals});
      $scope.$digest();

      expect(proposalsCtrl.proposals).toEqual(proposals);
    });

    it('should alert the user if the proposals do not load', function(){
      spyOn($window, 'alert');
      deffered.reject('error');
      expect(function(){
        $scope.$digest();
      }).toThrow();
      expect($window.alert).toHaveBeenCalled();
    });
  });
});
