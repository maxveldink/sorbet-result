# typed: true

require "minitest/assertions"
require "sorbet-result"

module Minitest
  module Assertions
    # Fails unless Result is a Success
    def assert_success(result)
      assert_kind_of(Typed::Success, result)
    end

    # Fails unless Result is a Failure
    def assert_failure(result)
      assert_kind_of(Typed::Failure, result)
    end

    # Fails unless exp is equal to payload
    def assert_payload(exp, result)
      assert_equal(exp, result.payload)
    end

    # Fails unless exp is equal to error
    def assert_error(exp, result)
      assert_equal(exp, result.error)
    end

    # Fails if Result is a Success
    def refute_success(result)
      refute_kind_of(Typed::Success, result)
    end

    # Fails if Result is a Failure
    def refute_failure(result)
      refute_kind_of(Typed::Failure, result)
    end

    # Fails if exp is equal to payload
    def refute_payload(exp, result)
      refute_equal(exp, result.payload)
    end

    # Fails if exp is equal to error
    def refute_error(exp, result)
      refute_equal(exp, result.error)
    end
  end
end
