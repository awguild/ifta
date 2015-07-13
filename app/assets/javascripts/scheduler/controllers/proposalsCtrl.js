angular.module('schedulerApp')
.controller('ProposalsCtrl', ['Proposals', '$window',
function(Proposals, $window){
  var self = this;
  this.proposals = [];

  Proposals.fetch().then(function(res){
    self.proposals = res.data;
  })
  .catch(function(err){
    $window.alert('Sorry, Unable to load proposal data. Try reloading the page.')
    throw err;
  });
}]);