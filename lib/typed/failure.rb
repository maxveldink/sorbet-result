# typed: strict
# frozen_string_literal: true

module Typed
  # Represents a failed result. Contains error information but no payload.
  class Failure < Result
    extend T::Sig
    extend T::Generic

    Payload = type_member { { fixed: T.noreturn } }
    Error = type_member

    sig { override.returns(Error) }
    attr_reader :error

    sig do
      type_parameters(:T)
        .params(error: T.type_parameter(:T))
        .returns(Typed::Failure[T.type_parameter(:T)])
    end
    def self.new(error)
      super(error)
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
        .type_parameters(:Fallback)
        .params(value: T.type_parameter(:Fallback))
        .returns(T.any(Payload, T.type_parameter(:Fallback)))
    end
    def payload_or(value)
      value
    end
  end
end
