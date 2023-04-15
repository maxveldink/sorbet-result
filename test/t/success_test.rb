# typed: true
# frozen_string_literal: true

require "test_helper"

class SuccessTest < Minitest::Test
  def setup
    @success = T::Success.new
  end

  def test_it_is_success
    assert_predicate @success, :success?
  end

  def test_it_is_not_failure
    refute_predicate @success, :failure?
  end
end
