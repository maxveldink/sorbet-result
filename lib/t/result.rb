# typed: strict
# frozen_string_literal: true

module T
  # A monad representing either a success or a failure. Contains payload and error information as well.
  class Result
    extend Sig
    extend Helpers
    extend Generic

    abstract!

    Payload = type_member
    Error = type_member

    sig { abstract.returns(Boolean) }
    def success?; end

    sig { abstract.returns(Boolean) }
    def failure?; end

    sig { abstract.returns(T.nilable(Payload)) }
    def payload; end

    sig { abstract.returns(T.nilable(Error)) }
    def error; end

    sig { abstract.returns(Payload) }
    def payload!; end
  end
end
