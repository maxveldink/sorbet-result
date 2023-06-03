# typed: strict
# frozen_string_literal: true

class TestGenerics
  extend T::Sig

  sig { params(should_succeed: T::Boolean).returns(Typed::Result[Integer, String]) }
  def test_generic_initializer(should_succeed)
    if should_succeed
      Typed::Success.new(1)
    else
      Typed::Failure.new(error: 1)
    end
  end

  sig { returns(Typed::Failure[String]) }
  def test_inferred_error_type
    failure = Typed::Failure.new(error: "error")

    T.assert_type!(failure.error, String)
    failure
  end

  sig { returns(Typed::Failure[Integer]) }
  def test_explicit_error_type
    Typed::Failure[Integer].new(error: "error")
  end
end
