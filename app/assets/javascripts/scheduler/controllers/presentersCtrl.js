angular.module('schedulerApp')
.controller('PresentersCtrl', ['Presenters', '$window',
function(Presenters, $window){
  var self = this;
  this.presenters = [];

  Presenters.fetch().then(function(res){
    self.presenters = res.data;
  })
  .catch(function(err){
    $window.alert('Sorry, Unable to load presenter data. Try reloading the page.')
    throw err;
  });
}]);