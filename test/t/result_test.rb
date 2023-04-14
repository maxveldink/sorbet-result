# typed: true
# frozen_string_literal: true

require "test_helper"

class ResultTest < Minitest::Test
  def test_it_exists
    assert T::Result.new
  end
end
