require 'turn'
#Turn.config.format = :pretty
require 'simplecov'
require 'simplecov-rcov'

class LineFilter < SimpleCov::Filter
  def matches?(source_file)
    source_file.lines.count < filter_argument
  end
end

class SimpleCov::Formatter::MergedFormatter
  def format(result)
    SimpleCov::Formatter::HTMLFormatter.new.format(result)
    SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

SimpleCov.start 'rails' do
  add_group "Long files" do |src_file|
    src_file.lines.count > 100
  end
end  

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'



class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
