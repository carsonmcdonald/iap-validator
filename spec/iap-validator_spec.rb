require 'helper'

RSpec.describe IAPValidator::IAPValidator do

  it 'should validate' do
    receipt_data = 'randomreceiptdata'
    expected_response = { "cool" => 123 }
    expected_response_str = MultiJson.dump(expected_response)

    stub = stub_request(:post, IAPValidator::IAPValidator::SANDBOX_URL + '/verifyReceipt').
        with(body: { 'receipt-data' => receipt_data }).
        and_return(status: 200, body: expected_response_str)

    resp = IAPValidator::IAPValidator.validate(receipt_data, true)

    expect(stub).to have_been_requested
    expect(resp).to eq(expected_response)
  end

  it 'should validate with error' do
    receipt_data = 'randomreceiptdata'
    expected_response = { "cool" => 123 }
    expected_response_str = MultiJson.dump(expected_response)

    stub = stub_request(:post, IAPValidator::IAPValidator::SANDBOX_URL + '/verifyReceipt').
        with(body: { 'receipt-data' => receipt_data }).
        and_return(status: 400, body: expected_response_str)

    resp = IAPValidator::IAPValidator.validate(receipt_data, true)

    expect(stub).to have_been_requested
    expect(resp).to be_nil
  end

end
