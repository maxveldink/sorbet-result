# typed: true
# frozen_string_literal: true

require "test_helper"

class SuccessTest < Minitest::Test
  def setup
    @success = Typed::Success.new("Testing")
    @success_without_payload = Typed::Success.new(nil)
  end

  def test_blank_is_convenience_for_nil_payload
    success = Typed::Success.blank

    assert_nil success.payload
  end

  def test_Success_convenience_method
    assert_equal Typed::Success.new("Testing"), Typed::Success("Testing")
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

  def test_error_raise_error
    assert_raises(Typed::NoErrorOnSuccessError) { @success.error }
    assert_raises(Typed::NoErrorOnSuccessError) { @success_without_payload.error }
  end

  def test_and_then_executes_block_with_payload_and_returns_result
    assert_equal("Testing", @success.and_then { |payload| Typed::Success.new(payload) }.payload)
    assert_equal(@success_without_payload, @success_without_payload.and_then { |_payload| @success_without_payload })
  end

  def test_on_error_does_not_call_block_and_returns_self
    assert_equal(@success, @success.on_error { raise "Ran on_error block on Success type" })
  end

  def test_payload_or_returns_payload
    assert_equal("Testing", @success.payload_or(2))
  end

  def test_equals_works
    assert_equal(@success, Typed::Success.new("Testing"))
    refute_equal(@success, Typed::Success.blank)
    refute_equal(@success, Typed::Failure.blank)
  end
end
