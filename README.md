# MethodCallTracer

A simple example of tracing Ruby's method calls with TracePoint.
TracePoint is a built-in feature of Ruby >= 2.0.

With this script, you can get the list of methods actually called.
You may use this to find unused method in your codebase.

## Usage

Just require trace_method_call.rb and it will dump the list of
methods called during execution at the end of the program.

You can use ruby's -r option:

    $ ruby -r ./trace_method_call.rb examples/a.rb

Or rspec's -r option, etc.

    $ bundle exec rspec -r ~/somewhere/trace_method_call.rb

Note: this may be very slow (eg. 5sec -> 2min)

## License

MIT

## Contact

https://github.com/yhara/method_call_tracer
