class AstBinary < ExAst

  def initialize(op, left, right)
    @op = op
    @left = left
    @right = right
  end

end
