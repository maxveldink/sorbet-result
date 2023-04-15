# typed: strict
# frozen_string_literal: true

module T
  # Represents a successful result. Contains a payload and no error information.
  class Success < Result
    extend T::Sig

    sig { override.returns(T::Boolean) }
    def success?
      true
    end

    sig { override.returns(T::Boolean) }
    def failure?
      false
    end
  end
end
