# typed: strict
# frozen_string_literal: true

class TestGenerics
  extend T::Sig

  sig { params(should_succeed: T::Boolean).returns(Typed::Result[Integer, String]) }
  def test_generic_initializer(should_succeed)
    if should_succeed
      Typed::Success.new(1)
    else
      Typed::Failure.new(1)
    end
  end

  sig { returns(Typed::Failure[String]) }
  def test_inferred_error_type
    failure = Typed::Failure.new("error")

    T.assert_type!(failure.error, String)
    failure
  end

  sig { returns(Typed::Failure[Integer]) }
  def test_explicit_error_type
    Typed::Failure[Integer].new("error")
  end

  sig { void }
  def test_payload_or
    success = Typed::Failure.new("success")

    success.payload_or(1).upcase
  end

  sig { void }
  def test_passed_on_error_type
    Typed::Failure.new("error").on_error do |error|
      T.assert_type!(error, String)
    end
  end
end
