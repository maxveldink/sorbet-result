# typed: true
# frozen_string_literal: true

require "test_helper"

class FailureTest < Minitest::Test
  def setup
    @failure = T::Failure.new
  end

  def test_it_is_failure
    assert_predicate @failure, :failure?
  end

  def test_it_is_not_success
    refute_predicate @failure, :success?
  end
end
