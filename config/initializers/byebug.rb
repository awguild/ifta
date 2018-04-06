if Rails.env.development?
  Byebug.start_server 'localhost', ENV.fetch("BYEBUG_SERVER_PORT", 1048).to_i
end
