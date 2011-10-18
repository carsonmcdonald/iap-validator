iap-validator can be used to validate base64 encoded iTunes in app purchase receipts.

## Getting started

If you haven't read the [Apple StoreKit Guide](http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/StoreKitGuide/Introduction/Introduction.html) do that first to get an understanding of StoreKit.

Next take a look at this greate [introduction to in app purchases](http://www.raywenderlich.com/2797/introduction-to-in-app-purchases) by Ray Wenderlich.

Once you are able to make purchases you are ready to use this gem. Check out the [reference for validating receipts](http://developer.apple.com/library/ios/#documentation/NetworkingInternet/Conceptual/StoreKitGuide/VerifyingStoreReceipts/VerifyingStoreReceipts.html) if you want to know more details of how the gem works.

The gem only works with base64 encoded data so you will need to do that first. There are a number of good libraries for doing that in Objective-C: [NSDataBase64](https://github.com/reklis/NSDataBase64) or [the Google toolbox for mac](http://code.google.com/p/google-toolbox-for-mac/)

Assuming you have read the introduction to in app purchases post above and are using the NSDataBase64 library you would add something like this to the example code to print out a base64 encoded receipt:

``` C
- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
  NSLog(@"Test transaction receipt: %@", [transaction.transactionReceipt base64EncodedString]);
}
```

Once you have your receipt base64 encoded you can verify it with the following code:

``` rb
require 'iap-validator'

receipt_data = 'PUT THE BASE64 ENCODED RECEIPT HERE'

# Is this a valid receipt?
if IAPValidator::IAPValidator.valid?(receipt_data, true)
  puts "Receipt is valid"
else
  puts "Receipt is not valid"
end

# You can also get more information about the receipt
resp = IAPValidator::IAPValidator.validate(receipt_data, true)
puts resp["status"]
```

In the above example the calls take true as the second argument indicating sandbox use. Without the second argument the calls will default to using the production validation system.

## Copyright

Copyright (c) 2011 Carson McDonald. See LICENSE.txt for further details.

