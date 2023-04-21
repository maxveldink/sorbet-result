# typed: true
# frozen_string_literal: true

require "test_helper"

class SuccessTest < Minitest::Test
  def setup
    @success = Typed::Success[String, String].new(payload: "Testing")
    @success_without_payload = Typed::Success.new
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

  def test_error_returns_nil
    assert_nil @success.error
    assert_nil @success_without_payload.error
  end

  def test_payload_bang_returns_payload_if_present
    assert_equal "Testing", @success.payload!
  end

  def test_payload_bang_raises_error_if_payload_is_nil
    assert_raises(Typed::NilPayloadError) { @success_without_payload.payload! }
  end
end
