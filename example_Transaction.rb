require './usaepay'

tran=UmTransaction.new

# Merchants Source key must be generated within the console
tran.key="_necKE3o9LGKB403ExdIz7w05NK80993"

# Send request to sandbox server not production.  Make sure to comment or remove this line before
#  putting your code into production
tran.usesandbox=true

tran.card="4444555566667779"
tran.exp="0919"
tran.amount="1.00"
tran.invoice="1234"
tran.cardholder="Test T Jones"
tran.street="1234 Main Street"
tran.zip="90036"
tran.description="Online Order"
tran.cvv2="435"
tran.custom3="testest"
tran.pin="1234"
tran.savecard=true
#tran.proxyurl="http://localhost:3128"
tran.timeout="30"


#addLine (sku, name, description, cost, qty, taxable, taxrate, taxamount, um, commoditycode, discountrate, discountamount, taxclass)
tran.addLine("SKU12345","Product Name","Product Description",0.19,10,0,"taxrate","taxamount","um","commoditycode","discountrate","discountamount","taxclass")



p "Please Wait One Moment While We process your card."

$stdout.flush

tran.process
if tran.resultcode.to_s=="A"
then
	p "Card approved"
	p "RefNum: #{tran.refnum} "
	p "Authcode: #{tran.authcode} "
	p "AVS Result: #{tran.avs_result} "
	p "Cvv2 Result: #{tran.cvv2_result} "
    p "getLineTotal: #{tran.getLineTotal}"

    p "Token Response:"
    p "Masked Card Num: #{tran.maskednum}"
    p "Token: #{tran.cardref}"
    p "CardType: #{tran.cardtype}"

else
	p "Card Declined #{tran.result} "
	p "Reason: #{tran.error}"
end
