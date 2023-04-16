# typed: strict
# frozen_string_literal: true

module T
  # Represents a failed result. Contains error information but no payload.
  class Failure
    extend Sig
    extend Generic

    include Result

    Payload = type_member
    Error = type_member

    sig { override.returns(T.nilable(Error)) }
    attr_reader :error

    sig { params(error: T.nilable(Error)).void }
    def initialize(error: nil)
      @error = error
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
