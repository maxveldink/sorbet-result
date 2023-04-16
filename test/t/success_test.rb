# typed: true
# frozen_string_literal: true

require "test_helper"

class SuccessTest < Minitest::Test
  def setup
    @success = T::Success[String].new(payload: "Testing")
    @success_without_payload = T::Success.new
  end

  def test_it_is_success
    assert_predicate @success, :success?
    assert_predicate @success_without_payload, :success?
  end

  def test_it_is_not_failure
    refute_predicate @success, :failure?
    refute_predicate @success_without_payload, :failure?
  end

  def test_payload_returns_payload
    assert_equal "Testing", @success.payload
    assert_nil @success_without_payload.payload
  end

  def test_unwrap_returns_payload_if_present
    assert_equal "Testing", @success.unwrap!
  end

  def test_unwrap_raises_error_if_payload_is_nil
    assert_raises(T::NilPayloadError) { @success_without_payload.unwrap! }
  end
end
