# typed: strict
# frozen_string_literal: true

module Typed
  # Represents a successful result. Contains a payload and no error information.
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
      super(payload)
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
  end
end
