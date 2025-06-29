# typed: true
# frozen_string_literal: true

require "test_helper"

class NoPayloadOnFailureErrorTest < Minitest::Test
  def test_initialize_with_string_error
    failure = Typed::Failure.new("Something went wrong")
    error = Typed::NoPayloadOnFailureError.new(failure)

    expected_message = "Attempted to access `payload` from a Failure Result. " \
                      "You were probably expecting a Success Result. " \
                      "Check the result with `#success?` or `#failure?` before attempting to access `payload`. " \
                      "Error encountered: \"Something went wrong\""

    assert_equal expected_message, error.message
  end

  def test_initialize_with_standard_error
    custom_error = StandardError.new("Custom error message")
    failure = Typed::Failure.new(custom_error)
    error = Typed::NoPayloadOnFailureError.new(failure)

    expected_message = "Attempted to access `payload` from a Failure Result. " \
                      "You were probably expecting a Success Result. " \
                      "Check the result with `#success?` or `#failure?` before attempting to access `payload`. " \
                      "Error encountered: #<StandardError: Custom error message>"

    assert_equal expected_message, error.message
  end

  def test_initialize_with_nil_error
    failure = Typed::Failure.blank
    error = Typed::NoPayloadOnFailureError.new(failure)

    expected_message = "Attempted to access `payload` from a Failure Result. " \
                      "You were probably expecting a Success Result. " \
                      "Check the result with `#success?` or `#failure?` before attempting to access `payload`. " \
                      "Error encountered: nil"

    assert_equal expected_message, error.message
  end
end
