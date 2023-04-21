# typed: strict
# frozen_string_literal: true

module Typed
  # Error when user attempts to access payload from a Failure Result.
  class NoPayloadOnFailureError < StandardError
    extend T::Sig

    sig { void }
    def initialize
      super("Attempted to access a payload from a Failure Result. You were probably expecting a Success Result. Check the result with #success? or #failure? before attempting to access the payload.") # rubocop:disable Layout/LineLength
    end
  end
end
