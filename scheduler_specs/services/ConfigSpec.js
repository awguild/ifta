describe('Config', function(){
  beforeEach(module('schedulerApp'));

  beforeEach(module(function($provide){
    $provide.value('$window', {gon: {conference_year: '2016'}});
  }));

  var Config;
  beforeEach(inject(function(_Config_){
    Config = _Config_;
  }));

  it('should have a conference_year property from gon', function(){
    expect(Config.conference_year).toEqual('2016');
  });
});