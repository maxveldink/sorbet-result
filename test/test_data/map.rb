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
  def test_map
    do_something(true)
      .map { |payload| do_something_else(T.assert_type!(payload, Integer) == 123) }
      .map { |payload| do_one_more_thing(T.assert_type!(payload, String) == "success") }
      .map { |payload| Typed::Success.new(T.assert_type!(payload, Time) == Time.now) }
  end

  sig { returns(T.any(String, Typed::Failure[T.any(String, Integer)])) }
  def test_flat_map
    do_something(true)
      .map { |payload| do_something_else(T.assert_type!(payload, Integer) == 123) }
      .flat_map { |payload| payload }
  end

  sig { returns(T.any(Time, String, Integer, Float)) }
  def test_return_type_check
    res = do_something(true)
          .map { |_payload| do_something_else(true) }
          .map { |_payload| do_one_more_thing(true) }

    if res.success?
      T.assert_type!(res.payload, Time)
    else
      T.assert_type!(res.error, T.any(String, Integer, Float))
    end
  end

  sig { returns(T.any(Typed::Failure[T.any(String, Integer)], String)) }
  def test_unreachability
    do_something(true)
      .map { |payload| Typed::Failure.new(payload) }
      .flat_map { |_payload| "this code is unreachable" }
  end
end
