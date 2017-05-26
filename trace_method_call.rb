require 'set'

class MethodCallTracer
  def initialize
    @called_methods = Set.new
    @tracepoint = TracePoint.new(:call) do |tp|
      if normal_name?(tp.defined_class.name)
        @called_methods << "#{tp.defined_class.name}##{tp.method_id}"
      elsif tp.self.respond_to?(:name) && normal_name?(tp.self.name)
        @called_methods << "#{tp.self.name}.#{tp.method_id}"
      else
        # Skip metaprogramming stuffs
        #$stderr.puts({defcls: tp.defined_class.inspect, 
        #              self: tp.self,
        #              method: tp.method_id}.inspect)
      end
    end
  end
  attr_reader :tracepoint, :called_methods

  def enable(&block)
    tracepoint.enable(&block)
  end

  def disable
    tracepoint.disable
    # Remove call of this method from the list
    # (This is not what you're interested in, right?)
    @called_methods.delete("MethodCallTracer#disable")
  end

  private

  def normal_name?(name)
    name && name =~ /\A[A-Z]\w*(::[A-Z]\w*)*\z/
  end
end

tracer = MethodCallTracer.new
tracer.enable

at_exit do
  tracer.disable
  puts "--- Called Methods ---"
  puts tracer.called_methods.sort
end
