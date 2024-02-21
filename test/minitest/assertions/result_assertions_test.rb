# typed: true

require "test_helper"

class ResultAssertionsTest < Minitest::Test
  def setup
    @success = Typed::Success.new("Test Payload")
    @failure = Typed::Failure.new("Test Error")
  end

  def test_success_assertions
    assert_success(@success)
    refute_success(@failure)
  end

  def test_failure_assertions
    assert_failure(@failure)
    refute_failure(@success)
  end

  def test_payload_assertions
    assert_payload("Test Payload", @success)
    refute_payload("Payload", @success)
  end

  def test_error_assertions
    assert_error("Test Error", @failure)
    refute_error("Error", @failure)
  end
end
