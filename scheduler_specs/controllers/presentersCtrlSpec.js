describe('PresentersCtrl', function(){
  beforeEach(module('schedulerApp'));

  var $q, $scope, $window, presentersCtrl, Presenters, deffered;
  beforeEach(inject(function($rootScope, _$window_, _$q_, $controller, _Presenters_){
    Presenters = _Presenters_;
    $window = _$window_;
    $q = _$q_;

    deffered = $q.defer();
    spyOn(Presenters, 'fetch').and.returnValue(deffered.promise);

    $scope = $rootScope.$new();
    presentersCtrl = $controller('PresentersCtrl', { $scope: $scope});
  }));

  describe('fetch presenters', function(){
    it('should fetch presenters and set them on the controller', function(){
      var presenters = {email: 'jdoe@test.com'};
      deffered.resolve({data: presenters});
      $scope.$digest();

      expect(presentersCtrl.presenters).toEqual(presenters);
    });

    it('should alert the user if the presenters do not load', function(){
      spyOn($window, 'alert');
      deffered.reject('error');
      expect(function(){
        $scope.$digest();
      }).toThrow();
      expect($window.alert).toHaveBeenCalled();
    });
  });
});