# frozen_string_literal: true

require_relative "notifications/version"
require "active_support/core_ext/string"
require "active_support"
require "active_support/notifications"

module Rspec
  module Matchers
    module ActiveSupport
      module Notifications
        class NegationNotSupportedError < StandardError; end

        class Matcher
          def initialize(expected)
            @expected = expected
            set_expected_number(:exactly, 1)
          end

          def exactly(count) = tap { set_expected_number(:exactly, count) }

          def at_least(count) = tap { set_expected_number(:at_least, count) }

          def at_most(count) = tap { set_expected_number(:at_most, count) }

          def times = self

          def once = exactly(:once)

          def twice = exactly(:twice)

          def thrice = exactly(:thrice)

          def supports_block_expectations? = true

          def does_not_match?(target)
            raise NegationNotSupportedError.new <<~MSG.squish
              Using the `emit_event` matcher in negation may bring surprising
              outcomes and it's not supported.
            MSG
          end

          def matches?(target)
            captured = Hash.new { 0 }
            handler = lambda { |name, *_| captured[name] += 1 }

            ::ActiveSupport::Notifications.subscribed(handler, @expected, &target)

            if @expected.is_a?(Regexp)
              @got = captured.select { |k, v| k =~ @expected }.map(&:last).sum
            end

            @got ||= captured[@expected]

            case @expectation_type
            when :exactly then @expected_number == @got
            when :at_most then @expected_number >= @got
            when :at_least then @expected_number <= @got
            end
          end

          def failure_message
            <<~MSG.squish
              expected block to emit event #{@expected.inspect}
              #{@expected_number} #{"time".pluralize(@expected_number)}
              but happened #{@got} #{"time".pluralize(@got)}
            MSG
          end

          def failure_message_when_negated
            <<~MSG.squish
              expected block not to emit event #{@expected.inspect}
              but happened #{@got} #{"time".pluralize(@got)}
            MSG
          end

          protected

          def set_expected_number(relativity, count)
            @expectation_type = relativity
            @expected_number = case count
            when :once then 1
            when :twice then 2
            when :thrice then 3
            else Integer(count)
            end
          end
        end

        def emit_event(expected)
          Matcher.new(expected)
        end
      end
    end
  end
end
