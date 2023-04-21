# typed: strict
# frozen_string_literal: true

module Typed
  # Represents a successful result. Contains a payload and no error information.
  class Success < Result
    extend T::Sig
    extend T::Generic

    Payload = type_member
    Error = type_member

    sig { override.returns(T.nilable(Payload)) }
    attr_reader :payload

    sig { params(payload: T.nilable(Payload)).void }
    def initialize(payload: nil)
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

    sig { override.returns(Payload) }
    def payload!
      case @payload
      when nil
        raise NilPayloadError
      else
        @payload
      end
    end
  end
end
