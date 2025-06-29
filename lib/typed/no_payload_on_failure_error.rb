# typed: strict
# frozen_string_literal: true

module Typed
  # Error when user attempts to access payload from a Failure Result.
  class NoPayloadOnFailureError < StandardError
    extend T::Sig

    sig { params(failure: Failure[T.untyped]).void }
    def initialize(failure)
      super(
        "Attempted to access `payload` from a Failure Result. " \
        "You were probably expecting a Success Result. " \
        "Check the result with `#success?` or `#failure?` before attempting to access `payload`. " \
        "Error encountered: #{failure.error.inspect}"
      )
    end
  end
end
