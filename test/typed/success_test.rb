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
    assert_raises(StandardError) { @success.error }
    assert_raises(StandardError) { @success_without_payload.error }
  end

  def test_map_executes_block_with_payload_and_returns_result
    assert_equal("Testing", @success.map { |payload| Typed::Success.new(payload) }.payload)
    assert_equal(@success_without_payload, @success_without_payload.map { |_payload| @success_without_payload })
  end

  def test_flat_map_executes_block_with_payload_and_returns_result
    assert_equal("Testing", @success.flat_map { |payload| payload })
    assert_nil(@success_without_payload.flat_map { |payload| payload })
    assert_equal("something else", @success_without_payload.flat_map { |_payload| "something else" })
  end
end
