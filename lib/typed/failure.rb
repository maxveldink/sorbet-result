# typed: strict
# frozen_string_literal: true

module Typed
  # Represents a failed result. Contains error information but no payload.
  class Failure < Result
    extend T::Sig
    extend T::Generic

    Payload = type_member { { fixed: T.untyped } }
    Error = type_member

    sig { override.returns(T.nilable(Error)) }
    attr_reader :error

    sig do
      type_parameters(:T)
        .params(error: T.nilable(T.type_parameter(:T)))
        .returns(Typed::Failure[T.type_parameter(:T)])
    end
    def self.new(error: nil)
      super(error: error)
    end

    sig { params(error: T.nilable(Error)).void }
    def initialize(error: nil)
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

    sig { override.returns(T.nilable(Payload)) }
    def payload
      nil
    end

    sig { override.returns(Payload) }
    def payload!
      raise NoPayloadOnFailureError
    end
  end
end
