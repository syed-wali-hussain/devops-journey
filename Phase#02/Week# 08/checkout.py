def process_checkout(cart, payment):
"""Process checkout"""
if not cart:
raise ValueError("Cart empty")
  if not validate_payment(payment):
raise ValueError("Payment invalid")
  total = sum([item['price'] for item in cart])
return {"status": "success", "total": total}
 def validate_payment(payment):
return 'card_number' in payment
