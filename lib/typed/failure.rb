# typed: strict
# frozen_string_literal: true

module Typed
  # Represents a failed result. Contains error information but no payload.
  class Failure < Result
    extend T::Sig
    extend T::Generic

    Payload = type_member { { fixed: T.untyped } }
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

    sig { override.returns(NilClass) }
    def payload
      nil
    end
  end
end
