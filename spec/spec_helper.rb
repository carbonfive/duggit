require 'rubygems'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :mocha

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Authentication, :type => :controller

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end

require 'rspec/core/formatters/base_text_formatter'
module RSpec
  module Core
    module Formatters

      class BaseTextFormatter < BaseFormatter

        private

        def dump_failure(example, index)
          exception = example.execution_result[:exception]
          output.puts "#{short_padding}#{index.next}) #{example.full_description}"
          output.puts "#{long_padding}#{red("Failure/Error:")} #{red(read_failed_line(exception, example).strip)}"
          output.puts "#{long_padding}#{red(exception.class.name << ":")}" unless exception.class.name =~ /RSpec/
          exception.message.split("\n").each { |line| output.puts "#{long_padding}  #{red(line)}" } if exception.message

          example.example_group.ancestors.push(example.example_group).each do |group|
            if group.metadata[:shared_group_name]
              output.puts "#{long_padding}Shared Example Group: \"#{group.metadata[:shared_group_name]}\" called from " +
                              "#{backtrace_line(group.metadata[:example_group][:location])}"
              break
            end
          end
        end

      end

    end
  end
end
