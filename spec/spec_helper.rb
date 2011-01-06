require 'rspec'
require "rubygems"
gem "sanitize"
require "sanitize"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'simple_html_helper'

Spec::Runner.configure do |config|
  
end
