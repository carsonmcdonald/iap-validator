require 'iap-validator/version'

require 'multi_json'
require 'typhoeus'

module IAPValidator
  class IAPValidator
    SANDBOX_URL = 'https://sandbox.itunes.apple.com'.freeze
    PRODUCTION_URL = 'https://buy.itunes.apple.com'.freeze

    HEADERS = {
      'Content-Type': 'application/json'
    }.freeze

    def self.validate(data, sandbox = false, password = nil)
      base_uri = sandbox ? SANDBOX_URL : PRODUCTION_URL

      json = if password.nil?
                { 'receipt-data' => data }
             else
                { 'receipt-data' => data, 'password' => password }
             end

      uri = URI.join(base_uri, '/verifyReceipt')

      resp = Typhoeus.post(uri, body: MultiJson.encode(json), headers: HEADERS)

      return nil unless resp.code == 200

      MultiJson.decode(resp.body)
    end

    def self.valid?(data, sandbox = false)
      resp = validate(data, sandbox)
      !resp.nil? && resp['status'] == 0
    end
  end
end
