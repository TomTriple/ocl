class AstFunction < ExAst

  def initialize(name, args, body)
    puts "got definition #{name}, #{args.inspect}"
    @name = name
    @args = args
    @body = body
  end

end
