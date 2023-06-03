# typed: strict
# frozen_string_literal: true

module Typed
  # Represents a successful result. Contains a payload and no error information.
  class Success < Result
    extend T::Sig
    extend T::Generic

    Payload = type_member
    Error = type_member { { fixed: T.untyped } }

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

    sig { override.returns(NilClass) }
    def error
      nil
    end
  end
end
