# typed: strict
# frozen_string_literal: true

module Typed
  # Error when user attempts to access payload from a Failure Result.
  class NoErrorOnSuccessError < StandardError
    extend T::Sig

    sig { void }
    def initialize
      super("Attempted to access `error` from a Success Result. You were probably expecting a Failure Result. Check the result with `#success?` or `#failure?` before attempting to access `error`.") # rubocop:disable Layout/LineLength
    end
  end
end
