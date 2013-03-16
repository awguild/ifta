Recaptcha.configure do |config|
  config.public_key  = CONFIG[:recaptcha_public_key]
  config.private_key = CONFIG[:recaptcha_private_key]
  #config.proxy = 'http://myproxy.com.au:8080'
end