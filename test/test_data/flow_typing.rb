# typed: true
# frozen_string_literal: true

class TestGenerics
  extend T::Sig

  sig { params(should_succeed: T::Boolean).returns(Typed::Result[Integer, String]) }
  def do_something(should_succeed)
    if should_succeed
      Typed::Success.new(123)
    else
      Typed::Failure.new("")
    end
  end

  sig { void }
  def test_flow
    result = do_something(true)
    if result.success?
      T.assert_type!(result.payload, Integer)
    else
      T.assert_type!(result.error, String)
    end
  end

  sig { void }
  def test_case
    result = do_something(true)

    case do_something(true)
    when Typed::Success
      T.assert_type!(result.payload, Integer)
    when Typed::Failure
      T.assert_type!(result.error, String)
    else
      T.absurd(result)
    end
  end
end
