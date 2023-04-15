# typed: strict
# frozen_string_literal: true

module T
  # Represents a failed result. Contains error information but no payload.
  class Failure < Result
    extend T::Sig

    sig { override.returns(T::Boolean) }
    def success?
      false
    end

    sig { override.returns(T::Boolean) }
    def failure?
      true
    end
  end
end
