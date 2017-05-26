class A
  def self.asdf

  end

  def foo
    p yield
  end

  def bar
    # do nothing
  end
end

A.new.foo{ 1 }
A.new.bar{ 1 }
A.asdf
