#!/usr/bin/env bash
set -euo pipefail

rails_versions=("7" "8" "8_1")

for version in "${rails_versions[@]}"; do
  echo "=== Testing with Rails $version ==="
  BUNDLE_GEMFILE="$(pwd)/gemfiles/rails_${version}.gemfile" bundle install --quiet
  BUNDLE_GEMFILE="$(pwd)/gemfiles/rails_${version}.gemfile" bin/rake test_all
  echo ""
done
