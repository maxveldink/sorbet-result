# typed: strict
# frozen_string_literal: true

require_relative "no_error_on_success_error"
require_relative "no_payload_on_failure_error"

module Typed
  extend T::Sig

  # A monad representing either a success or a failure. Contains payload and error information as well.
  class Result
    extend T::Sig
    extend T::Helpers
    extend T::Generic

    abstract!
    sealed!

    Payload = type_member(:out)
    Error = type_member(:out)

    sig { abstract.returns(T::Boolean) }
    def success?
    end

    sig { abstract.returns(T::Boolean) }
    def failure?
    end

    sig { abstract.returns(Payload) }
    def payload
    end

    sig { abstract.returns(Error) }
    def error
    end

    sig do
      abstract
        .type_parameters(:U, :T)
        .params(_block: T.proc.params(arg0: Payload).returns(Result[T.type_parameter(:U), T.type_parameter(:T)]))
        .returns(T.any(Result[T.type_parameter(:U), T.type_parameter(:T)], Result[T.type_parameter(:U), Error]))
    end
    def and_then(&_block)
    end

    sig do
      abstract
        .params(block: T.proc.params(arg0: Error).void)
        .returns(T.self_type)
    end
    def on_error(&block)
    end

    sig do
      abstract
        .type_parameters(:Fallback)
        .params(value: T.type_parameter(:Fallback))
        .returns(T.any(Payload, T.type_parameter(:Fallback)))
    end
    def payload_or(value)
    end
  end

  class Success < Result
    extend T::Sig
    extend T::Generic

    Payload = type_member
    Error = type_member { {fixed: T.noreturn} }

    sig { override.returns(Payload) }
    attr_reader :payload

    sig do
      type_parameters(:T)
        .params(payload: T.type_parameter(:T))
        .returns(Typed::Success[T.type_parameter(:T)])
    end
    def self.new(payload)
      super
    end

    sig { returns(Typed::Success[NilClass]) }
    def self.blank
      new(nil)
    end

    sig { params(payload: Payload).void }
    def initialize(payload)
      @payload = payload
      super()
    end

    sig { override.returns(T::Boolean) }
    def success?
      true
    end

    sig { override.returns(T::Boolean) }
    def failure?
      false
    end

    sig { override.returns(T.noreturn) }
    def error
      raise NoErrorOnSuccessError
    end

    sig do
      override
        .type_parameters(:U, :T)
        .params(block: T.proc.params(arg0: Payload).returns(Result[T.type_parameter(:U), T.type_parameter(:T)]))
        .returns(Result[T.type_parameter(:U), T.type_parameter(:T)])
    end
    def and_then(&block)
      block.call(payload)
    end

    sig do
      override
        .params(_block: T.proc.params(arg0: Error).void)
        .returns(T.self_type)
    end
    def on_error(&_block)
      self
    end

    sig do
      override
        .type_parameters(:Fallback)
        .params(_value: T.type_parameter(:Fallback))
        .returns(T.any(Payload, T.type_parameter(:Fallback)))
    end
    def payload_or(_value)
      payload
    end

    sig { params(other: T.untyped).returns(T::Boolean) }
    def ==(other)
      other.is_a?(Success) && other.payload == payload
    end
  end

  sig do
    type_parameters(:T)
      .params(payload: T.type_parameter(:T))
      .returns(Typed::Success[T.type_parameter(:T)])
  end
  def self.Success(payload)
    Success.new(payload)
  end

  class Failure < Result
    extend T::Sig
    extend T::Generic

    Payload = type_member { {fixed: T.noreturn} }
    Error = type_member

    sig { override.returns(Error) }
    attr_reader :error

    sig do
      type_parameters(:T)
        .params(error: T.type_parameter(:T))
        .returns(Typed::Failure[T.type_parameter(:T)])
    end
    def self.new(error)
      super
    end

    sig { returns(Typed::Failure[NilClass]) }
    def self.blank
      new(nil)
    end

    sig { params(error: Error).void }
    def initialize(error)
      @error = error
      super()
    end

    sig { override.returns(T::Boolean) }
    def success?
      false
    end

    sig { override.returns(T::Boolean) }
    def failure?
      true
    end

    sig { override.returns(T.noreturn) }
    def payload
      raise NoPayloadOnFailureError
    end

    sig do
      override
        .type_parameters(:U, :T)
        .params(_block: T.proc.params(arg0: Payload).returns(Result[T.type_parameter(:U), T.type_parameter(:T)]))
        .returns(Result[T.type_parameter(:U), Error])
    end
    def and_then(&_block)
      self
    end

    sig do
      override
        .params(block: T.proc.params(arg0: Error).void)
        .returns(T.self_type)
    end
    def on_error(&block)
      block.call(error)
      self
    end

    sig do
      override
        .type_parameters(:Fallback)
        .params(value: T.type_parameter(:Fallback))
        .returns(T.any(Payload, T.type_parameter(:Fallback)))
    end
    def payload_or(value)
      value
    end
  end
end
