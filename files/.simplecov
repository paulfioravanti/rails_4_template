# Only run Simplecov when not using a distributed Ruby server
# To get coverage, stop spork and run rspec
unless ENV['DRB']
  SimpleCov.start 'rails'
end
# if ENV['TRAVIS']
#  require 'coveralls'
#  Coveralls.wear! 'rails'
# end