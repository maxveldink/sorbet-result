# typed: strict
# frozen_string_literal: true

module T
  # Represents a failed result. Contains error information but no payload.
  class Failure < Result
    extend Sig
    extend Generic

    Payload = type_member

    sig { void }
    def initialize
      super(payload: nil)
    end

    sig { override.returns(Boolean) }
    def success?
      false
    end

    sig { override.returns(Boolean) }
    def failure?
      true
    end

    sig { override.returns(T.nilable(Payload)) }
    def payload
      nil
    end

    sig { override.returns(Payload) }
    def unwrap!
      raise UnwrappingFailureError
    end
  end
end
