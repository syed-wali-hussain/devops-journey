import yaml
import random
 class FeatureFlags:
def __init__(self, config_file):
with open(config_file, 'r') as f:
self.config = yaml.safe_load(f)
  def is_enabled(self, feature_name, user_id=None):
"""Check if feature is enabled for user"""
if feature_name not in self.config['features']:
return False
  feature = self.config['features'][feature_name]
  # Check if enabled
if not feature['enabled']:
return False
  # Check rollout percentage
rollout = feature.get('rollout_percentage', 0)
if random.randint(1, 100) > rollout:
return False
  return True
 # Initialize
flags = FeatureFlags('config/features.yaml')
 # Usage
if flags.is_enabled('user_profile'):
print("User profile feature is active")
 if flags.is_enabled('advanced_dashboard'):
print("Advanced dashboard is active")
else:
print("Using standard dashboard")
