beforeEach(module('schedulerApp'));

beforeEach(module(function($provide){
  $provide.value('Config', {conference_year: '2015'});
}));
