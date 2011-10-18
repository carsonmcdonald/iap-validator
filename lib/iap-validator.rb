require "iap-validator/version"

require 'httparty'

module IAPValidator
  class IAPValidator
    include HTTParty

    SANDBOX_URL = 'https://sandbox.itunes.apple.com'
    PRODUCTION_URL = 'https://buy.itunes.apple.com'

    base_uri PRODUCTION_URL

    headers 'Content-Type' => 'application/json'
    format :json

    def self.validate(data, sandbox = false)
      base_uri SANDBOX_URL if sandbox

      resp = post('/verifyReceipt', :body => MultiJson.encode({ 'receipt-data' => data }) )

      if resp.code == 200
        MultiJson.decode(resp.body())
      else
        nil
      end
    end

    def self.valid?(data, sandbox = false)
      resp = validate(data, sandbox)
      !resp.nil? && resp['status'] == 0
    end
  end
end
