def test_checkout_success():
cart = [{"name": "item1", "price": 10}]
payment = {"card_number": "1234"}
result = process_checkout(cart, payment)
assert result['status'] == 'success'
assert result['total'] == 10
 def test_checkout_empty_cart():
with pytest.raises(ValueError):
process_checkout([], {})
 def test_checkout_invalid_payment():
cart = [{"name": "item1", "price": 10}]
with pytest.raises(ValueError):
process_checkout(cart, {})
