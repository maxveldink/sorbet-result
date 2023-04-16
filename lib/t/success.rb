# typed: strict
# frozen_string_literal: true

module T
  # Represents a successful result. Contains a payload and no error information.
  class Success
    extend Sig
    extend Generic

    include Result

    Payload = type_member

    sig { override.returns(T.nilable(Payload)) }
    attr_reader :payload

    sig { params(payload: T.nilable(Payload)).void }
    def initialize(payload: nil)
      @payload = payload
    end

    sig { override.returns(Boolean) }
    def success?
      true
    end

    sig { override.returns(Boolean) }
    def failure?
      false
    end

    sig { override.returns(Payload) }
    def unwrap!
      case @payload
      when nil
        raise NilPayloadError
      else
        @payload
      end
    end
  end
end
