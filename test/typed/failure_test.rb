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
    assert_raises(StandardError) { @failure.payload }
    assert_raises(StandardError) { @failure_without_error.payload }
  end

  def test_error_returns_given_error
    assert_equal "Something bad", @failure.error
    assert_nil @failure_without_error.error
  end

  def test_map_does_not_execute_block_and_returns_self
    assert_equal(@failure, @failure.map { "Should not be called" })
    assert_equal(@failure_without_error, @failure_without_error.map { "Should not be called" })
  end

  def test_flat_map_does_not_execute_block_and_returns_self
    assert_equal(@failure, @failure.flat_map { |payload| payload })
    assert_equal(@failure_without_error, @failure_without_error.flat_map { |payload| payload })
  end
end
