describe('Config', function(){
  beforeEach(module('schedulerApp'));

  var Config;
  beforeEach(inject(function(_Config_){
    Config = _Config_;
  }));

  it('should have a settable conferenceYear property', function(){
    Config.conferenceYear = '2016'
    expect(Config.conferenceYear).toEqual('2016');
  });
});