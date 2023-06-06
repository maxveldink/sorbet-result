# typed: strict
# frozen_string_literal: true

module Typed
  # A monad representing either a success or a failure. Contains payload and error information as well.
  class Result
    extend T::Sig
    extend T::Helpers
    extend T::Generic

    abstract!

    Payload = type_member(:out)
    Error = type_member(:out)

    sig { abstract.returns(T::Boolean) }
    def success?; end

    sig { abstract.returns(T::Boolean) }
    def failure?; end

    sig { abstract.returns(Payload) }
    def payload; end

    sig { abstract.returns(Error) }
    def error; end

    sig do
      abstract
        .type_parameters(:U, :T)
        .params(_block: T.proc.params(arg0: Payload).returns(Result[T.type_parameter(:U), T.type_parameter(:T)]))
        .returns(T.any(Result[T.type_parameter(:U), T.type_parameter(:T)], Result[T.type_parameter(:U), Error]))
    end
    def map(&_block); end

    sig do
      abstract
        .type_parameters(:U)
        .params(_block: T.proc.params(arg0: Payload).returns(T.type_parameter(:U)))
        .returns(T.any(T.type_parameter(:U), Typed::Failure[Error]))
    end
    def flat_map(&_block); end
  end
end
