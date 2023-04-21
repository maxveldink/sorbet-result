# Typed::Result, Typed::Success and Typed::Failure

A simple, strongly-typed monad for modeling results, helping you implement [Railway Oriented Programming concepts](https://blog.logrocket.com/what-is-railway-oriented-programming/) in Ruby. Helps alleviate error-driven development, all the while boosting your confidence with Sorbet static checks.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add sorbet-result

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install sorbet-result

## Usage

Using a basic Result in your methods is as simple as indicating something could return a `Typed::Result`.

```ruby
sig { params(resource_id: Integer).returns(Typed::Result) }
def call_api(resource_id)
  # something bad happened
  return Typed::Failure.new

  # something other bad thing happened
  return Typed::Failure.new

  # Success!
  Typed::Success.new
end
```

Generally, it's nice to have a payload with results, and it's nice to have more information on failures. We can indicate what types these are in our signatures for better static checks. Note that payloads and errors can be _any_ type.

```ruby
sig { params(resource_id: Integer).returns(Typed::Result[Float, String]) }
def call_api(resource_id)
  # something bad happened
  return Typed::Failure.new(error: "I couldn't do it!")

  # something other bad thing happened
  return Typed::Failure.new(error: "I couldn't do it for another reason!")

  # Success!
  Typed::Success.new(payload: 1.12)
end
```

*Note:* We use Sorbet's generics for payload and error typing. The generic payload and error types are erased at runtime, so you won't get a type error at runtime if you violate the generic types. These types will help you statically so be sure to run `srb tc` on your project.

Further, if another part of your program needs the Result, it can depend on _only_ `Typed::Success`es (or `Typed::Failure`s if you're doing something with those results).

```ruby
sig { params(success_result: Typed::Success).void }
def do_something_with_resource(success_result)
  ...
end
```

Finally, there are a few methods you can use on both `Typed::Result` types.

```ruby
result = call_api(1)

result.success? # => true if success, false if failure
result.failure? # => true if failure, false if success

result.error # => nil on success, nil or error type on failure

result.payload # => nil on failure, nil or payload type on failure

result.payload! # => payload type or raises NilPayloadError on success, raises NoPayloadOnFailureError on failure
```

The `payload!` method is useful if you don't want to do a `T.must` escape hatch, since the payload _could_ always be `nil`. If you're writing Railway inspired code, you should do the `success?` check before calling `payload!` and know that you've returned a payload on the Result.

### Why use Results?

Let's say you're working on a method that reaches out to an API and fetches a resource. We hope to get a successful response and continue on in our program, but you can imagine several scenarios where we don't get that response: our authentication could fail, the server could return a 5XX response code, or the resource we were querying could have moved or not exist any more.

You might be tempted to use exceptions to model these "off-ramps" from the method.

```ruby
sig { params(resource_id: Integer).returns(Float) }
def call_api(resource_id)
  # something bad happened
  raise ArgumentError

  # something other bad thing happened
  raise StandardError

  # Success!
  1.12
end
```

This has several downsides; primarily, this required your caller to _know_ what exceptions to watch out for, or risk bubbling the error all the way out of your program when you could have recovered from it. Our Sorbet signature also becomes less helpful, as we can't indicate what errors could be raised here.

Railway Oriented Programming, which comes from the functional programming community, alleviates this by _expecting_ the failure states and making them a part of the normal flow of a method. Most errors are recoverable; at the very least we can message them back to the user in some way. We should inform the caller with a Result that could be either a Success or Failure, and allow them continue or take an "off-ramp" with a failure message. If we embrace this style of programming, our `call_api` method turns into this:

```ruby
sig { params(resource_id: Integer).returns(Typed::Result[Float, String]) }
def call_api(resource_id)
  # something bad happened
  return Typed::Failure.new(error: "I couldn't do it!")

  # something other bad thing happened
  return Typed::Failure.new(error: "I couldn't do it for another reason!")

  # Success!
  Typed::Success.new(payload: 1.12)
end
```

Sorbet is useful here now, as it the signature covers all possible return values and informs the caller what it should do: check the result status first, then do something with the error or payload. Statically, Sorbet will also know the types associated with our Result for better typechecking across the codebase.

Our caller doesn't need to guess which errors to rescue from (or doesn't need to be paranoid about rescuing all errors) and can proceed in both a success and a failure case.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run Rubocop and the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/maxveldink/sorbet-result. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/maxveldink/sorbet-result/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in this project's codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/maxveldink/sorbet-result/blob/master/CODE_OF_CONDUCT.md).

## Sponsorships

I love creating in the open. If you find this or any other [maxveld.ink](https://maxveld.ink) content useful, please consider sponsoring me on [GitHub](https://github.com/sponsors/maxveldink).
