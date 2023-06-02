# typed: true
# frozen_string_literal: true

class TestGenerics
  extend T::Sig

  sig { params(should_succeed: T::Boolean).returns(Typed::Result[Integer, String]) }
  def test(should_succeed)
    if should_succeed
      Typed::Success.new(payload: "1")
    else
      Typed::Failure.new(error: "")
    end
  end
end
