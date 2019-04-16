require 'helper'

RSpec.describe IAPValidator::IAPValidator do

  it 'should validate' do
    receipt_data = 'randomreceiptdata'
    expected_response = { "cool" => 123 }
    expected_response_str = MultiJson.dump(expected_response)

    stub_request(:post, IAPValidator::IAPValidator::SANDBOX_URL + '/verifyReceipt').
        with(body: { 'receipt-data' => receipt_data }).
        and_return(status: 200, body: expected_response_str)

    resp = IAPValidator::IAPValidator.validate(receipt_data, true)
    expect(resp).to eq(expected_response)
  end

  it 'should validate with error callback' do
    receipt_data = 'randomreceiptdata'
    expected_response = { "cool" => 123 }
    expected_response_str = MultiJson.dump(expected_response)

    stub_request(:post, IAPValidator::IAPValidator::SANDBOX_URL + '/verifyReceipt').
        with(body: { 'receipt-data' => receipt_data }).
        and_return(status: 400, body: expected_response_str)

    error = nil
    resp = IAPValidator::IAPValidator.validate(receipt_data, true) do |error_resp|
      error = error_resp
    end

    expect(resp).to be_nil
    expect(error).to_not be_nil
    expect(error.code).to eq(400)
    expect(error.body).to eq(expected_response_str)
  end

  it 'should validate without error callback' do
    receipt_data = 'randomreceiptdata'
    expected_response = { "cool" => 123 }
    expected_response_str = MultiJson.dump(expected_response)

    stub_request(:post, IAPValidator::IAPValidator::SANDBOX_URL + '/verifyReceipt').
        with(body: { 'receipt-data' => receipt_data }).
        and_return(status: 400, body: expected_response_str)

    error = nil
    resp = IAPValidator::IAPValidator.validate(receipt_data, true)

    expect(resp).to be_nil
    expect(error).to be_nil
  end

end
