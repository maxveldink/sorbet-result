# typed: true
# frozen_string_literal: true

class TestGenerics
  extend T::Sig

  sig { params(should_succeed: T::Boolean).returns(Typed::Result[Integer, String]) }
  def test_generic_initializer(should_succeed)
    if should_succeed
      Typed::Success.new("1")
    else
      Typed::Failure.new("")
    end
  end

  sig { returns(Typed::Success[String]) }
  def test_inferred_payload_type
    success = Typed::Success.new("success")

    T.assert_type!(success.payload, String)
    success
  end

  sig { returns(Typed::Success[Integer]) }
  def test_explicit_payload_type
    Typed::Success[Integer].new("success")
  end

  sig { void }
  def test_payload_or
    success = Typed::Success.new("success")

    success.payload_or(1).upcase
  end
end
