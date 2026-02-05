#!/usr/bin/env ruby
# Runner script for Hackety Hack on Scarpe — SKIPS SPLASH
# Pre-loads compatibility shims for dead dependencies

# Load the hpricot shim and register it so `require 'hpricot'` is a no-op
shim_path = File.expand_path('lib/compat/hpricot_shim.rb', __dir__)
require shim_path
$LOADED_FEATURES << 'hpricot' unless $LOADED_FEATURES.include?('hpricot')
$LOADED_FEATURES << 'hpricot.rb' unless $LOADED_FEATURES.include?('hpricot.rb')

# Stub the dead hackety-hack.com API — force offline mode
module Web
  def self.check_internet_connection; false; end
  def self.internet_connection?; false; end
end

# Load app/boot.rb first so HH::PREFS is available
require 'app/boot'

# SKIP SPLASH: Set the preference to skip the animated intro
# This avoids the mask animation which has performance issues at 30fps
HH::PREFS['skip_intro'] = true

# Now load the mainwindow UI (it will see skip_intro = true)
require 'app/ui/mainwindow'
