# typed: strict
# frozen_string_literal: true

module T
  # Error when user attempts to unwrap from a Failure Result.
  class UnwrappingFailureError < StandardError
    extend Sig

    sig { void }
    def initialize
      super("Attempted to unwrap payload from a Failure Result. You were probably expecting a Success Result. Check the result with #success? or #failure? before attempting to unwrap.") # rubocop:disable Layout/LineLength
    end
  end
end
