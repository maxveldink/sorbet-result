# typed: true
# frozen_string_literal: true

class TestGenerics
  extend T::Sig

  sig { params(should_succeed: T::Boolean).returns(Typed::Result[Integer, String]) }
  def test_generic_initializer(should_succeed)
    if should_succeed
      Typed::Success.new(payload: "1")
    else
      Typed::Failure.new(error: "")
    end
  end

  sig { returns(Typed::Success[String]) }
  def test_inferred_payload_type
    success = Typed::Success.new(payload: "success")

    T.assert_type!(success.payload, String)
    success
  end

  sig { returns(Typed::Success[Integer]) }
  def test_explicit_payload_type
    Typed::Success[Integer].new(payload: "success")
  end
end
