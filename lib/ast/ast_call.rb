class AstCall < ExAst

  def initialize(val, args)
    @val = val
    @args = args
    puts "got call to #{val}, args: #{args.inspect}"
  end

end
