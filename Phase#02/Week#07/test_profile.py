def test_get_profile():
profile = get_user_profile(1)
assert profile['id'] == 1
 def test_update_profile():
result = update_profile(1, {})
assert result['status'] == 'updated'
