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

  sig { params(should_succeed: T::Boolean).returns(Typed::Result[String, Integer]) }
  def do_something_else(should_succeed)
    if should_succeed
      Typed::Success.new("success")
    else
      Typed::Failure.new(5)
    end
  end

  sig { params(should_succeed: T::Boolean).returns(Typed::Result[Time, Float]) }
  def do_one_more_thing(should_succeed)
    if should_succeed
      Typed::Success.new(Time.now)
    else
      Typed::Failure.new(3.14)
    end
  end

  sig { returns(Typed::Result[T::Boolean, T.any(String, Integer, Float)]) }
  def test_and_then
    do_something(true)
      .and_then { |payload| do_something_else(T.assert_type!(payload, Integer) == 123) }
      .and_then { |payload| do_one_more_thing(T.assert_type!(payload, String) == "success") }
      .and_then { |payload| Typed::Success.new(T.assert_type!(payload, Time) == Time.now) }
  end

  sig { returns(T.any(Time, String, Integer, Float)) }
  def test_return_type_check
    res = do_something(true)
          .and_then { |_payload| do_something_else(true) }
          .and_then { |_payload| do_one_more_thing(true) }

    if res.success?
      T.assert_type!(res.payload, Time)
    else
      T.assert_type!(res.error, T.any(String, Integer, Float))
    end
  end

  sig { returns(Typed::Result[T.noreturn, T.any(String, Integer)]) }
  def test_unreachability
    do_something(true)
      .and_then { |payload| Typed::Failure.new(payload) }
      .and_then { |_payload| Typed::Success.new("this code is unreachable") }
  end
end
