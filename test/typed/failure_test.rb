# typed: true
# frozen_string_literal: true

require "test_helper"

class FailureTest < Minitest::Test
  def setup
    @failure = Typed::Failure.new("Something bad")
    @failure_without_error = Typed::Failure.new(nil)
  end

  def test_blank_is_convenience_for_nil_error
    failure = Typed::Failure.blank

    assert_nil failure.error
  end

  def test_it_is_failure
    assert_predicate @failure, :failure?
    assert_predicate @failure_without_error, :failure?
  end

  def test_it_is_not_success
    refute_predicate @failure, :success?
    refute_predicate @failure_without_error, :success?
  end

  def test_payload_raise_error
    assert_raises(Typed::NoPayloadOnFailureError) { @failure.payload }
    assert_raises(Typed::NoPayloadOnFailureError) { @failure_without_error.payload }
  end

  def test_error_returns_given_error
    assert_equal "Something bad", @failure.error
    assert_nil @failure_without_error.error
  end

  def test_and_then_does_not_execute_block_and_returns_self
    assert_equal(@failure, @failure.and_then { "Should not be called" })
    assert_equal(@failure_without_error, @failure_without_error.and_then { "Should not be called" })
  end

  def test_on_error_calls_block_with_error_and_returns_self
    captured_error = T.let(nil, T.nilable(String))

    assert_equal(@failure, @failure.on_error { |error| captured_error = error })
    assert_equal("Something bad", captured_error)
  end

  def test_either_runs_on_failure
    assert_equal(
      "Error was Something bad",
      @failure.either(
        ->(payload) { raise "Ran on_success proc on Failure type" },
        ->(error) { "Error was #{error}" }
      )
    )

    assert_equal(
      "No error",
      @failure_without_error.either(
        ->(_payload) { raise "Ran on_success proc on Failure type" },
        ->(_error) { "No error" }
      )
    )
  end

  def test_payload_or_returns_value
    assert_equal(2, @failure.payload_or(2))
  end
end
