# typed: strict
# frozen_string_literal: true

module T
  # Error when user attempts to unwrap payload for Success Result without payload.
  class NilPayloadError < StandardError
    extend Sig

    sig { void }
    def initialize
      super("Attempted to unwrap payload from a Success Result where payload is nil. If you need to return a value, make sure the Result is initialized with a payload.") # rubocop:disable Layout/LineLength
    end
  end
end
