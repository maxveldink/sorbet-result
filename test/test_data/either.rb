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

  sig { returns(T.any(Float, Integer)) }
  def test_either
    do_something(true)
      .either(
        ->(payload) { payload.to_f },
        ->(error) { error.to_i }
      )
  end

  # TODO: Sorbet erases the type parameter generic return types,
  # so `lhs` and `rhs` are both `T.untyped` inside the body here
  sig { returns(T.any(Float, Integer)) }
  def test_return_type_check
    lhs = do_something(true)
      .either(
        ->(payload) { payload.to_f },
        ->(error) { error.to_i }
      )

    rhs = do_something(true)
      .either(
        ->(payload) { payload.to_f },
        ->(error) { error.to_i }
      )

    T.assert_type!(lhs, Float)
    T.assert_type!(rhs, Integer)
  end

  # TODO: I would like Sorbet would know this is unreachable, but it currently doesn't
  sig { returns(String) }
  def test_unreachability
    Typed::Failure.new("")
      .either(
        ->(_payload) { "unreachable" },
        ->(error) { error }
      )
  end
end
