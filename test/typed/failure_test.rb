# typed: true
# frozen_string_literal: true

require "test_helper"

class FailureTest < Minitest::Test
  def setup
    @failure = Typed::Failure.new(error: "Something bad")
    @failure_without_error = Typed::Failure.blank
  end

  def test_it_is_failure
    assert_predicate @failure, :failure?
    assert_predicate @failure_without_error, :failure?
  end

  def test_it_is_not_success
    refute_predicate @failure, :success?
    refute_predicate @failure_without_error, :success?
  end

  def test_payload_returns_nil
    assert_nil @failure.payload
    assert_nil @failure_without_error.payload
  end

  def test_error_returns_given_error
    assert_equal "Something bad", @failure.error
    assert_nil @failure_without_error.error
  end
end
