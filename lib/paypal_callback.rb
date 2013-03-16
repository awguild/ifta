require 'net/http'

module PaypalCallback
class PaypalCallback
  def initialize(params, raw_post, paypal_url)
    @params = params
    @raw = raw_post
    @paypal_url = paypal_url
  end

  def valid?
    uri = URI.parse(@paypal_url + '?cmd=_notify-validate')
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    response = http.post(uri.request_uri, @raw,
                         'Content-Length' => "#{@raw.size}",
                         'User-Agent' => "My custom user agent"
                       ).body

    raise StandardError.new("Faulty paypal result: #{response}") unless ["VERIFIED", "INVALID"].include?(response)
    raise StandardError.new("Invalid IPN: #{response}") unless response == "VERIFIED"

    true
  end

  def completed?
    @params[:payment_status] == "Completed"
  end

end
end