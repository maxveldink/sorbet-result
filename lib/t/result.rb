# typed: strict
# frozen_string_literal: true

module T
  # A monad representing either a success or a failure. Contains payload and error information as well.
  class Result
    extend T::Sig
    extend T::Helpers
    abstract!

    sig { abstract.returns(T::Boolean) }
    def success?; end

    sig { abstract.returns(T::Boolean) }
    def failure?; end
  end
end
