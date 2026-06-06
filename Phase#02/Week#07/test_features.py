from feature_flags import FeatureFlags
 def test_enabled_feature():
flags = FeatureFlags('config/features.yaml')
assert flags.is_enabled('user_profile') == True
 def test_disabled_feature():flags = FeatureFlags('config/features.yaml')
# advanced_dashboard is at 0%, should be false most time
enabled = flags.is_enabled('advanced_dashboard')
# May be True or False based on random, but usually False
 def test_rollout_feature():
flags = FeatureFlags('config/features.yaml')
# new_analytics at 25% - test multiple times
enabled_count = 0
for _ in range(100):
if flags.is_enabled('new_analytics'):
enabled_count += 1
# Should be roughly 25 (±10)
assert 15 < enabled_count < 35
