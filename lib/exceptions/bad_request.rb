module Exceptions
  class BadRequest < StandardError
    def initialize params
      @params = params
      Rails.logger.error "BadRequest: #{params.inspect}"
    end
  end
end