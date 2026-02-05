#!/usr/bin/env ruby
# Runner script for Hackety Hack on Scarpe
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

# Now load the real app
load 'app/ui/mainwindow.rb'
