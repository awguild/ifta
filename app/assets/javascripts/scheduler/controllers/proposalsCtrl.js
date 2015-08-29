angular.module('schedulerApp')
.controller('ProposalsCtrl', [
  'Format',
  'Proposals',
  '$window',
function(Format, Proposals, $window){
  var self = this;
  this.proposals = [];
  this.formats = [];

  Proposals.fetch().then(function(res){
    self.proposals = res.data;
  })
  .catch(function(err){
    $window.alert('Sorry, Unable to load proposal data. Try reloading the page.')
    throw err;
  });

  Format.fetch()
  .then(function(res){
    self.formats = res.data;
  })
  .catch(function(err){
    $window.alert('Sorry, Unable to load format data.')
  }) // TODO how do I want to handle errors

}]);
