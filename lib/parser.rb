class Parser

  def initialize(lexer)
    @lexer = lexer
  end

 
  def start
    puts "starting parser..."
    @lexer.next_tok
    parse_primary while true
  end 


  def parse_int
    exp_int = AstInteger.new(@lexer.tok_cur)
    @lexer.next_tok  
    exp_int
  end


  def parse_paren 
    @lexer.next_tok  
    exp = parse_primary 
    raise ") expected..." unless @lexer.tok_cur == ")"
    exp 
  end


  def parse_identifier 
    id = @lexer.tok_cur
    unless @lexer.next_tok == "("
      return AstVariable.new(id)
    end
    @lexer.next_tok 
    args = [] 
    while true
      break if @lexer.tok_cur == ")" 
      args << parse_primary
    end
    AstCall.new(id, args) 
  end


  def parse_definition
    id = @lexer.next_tok
    raise "( expected..." unless @lexer.next_tok == "("
    args = []

    while true
      @lexer.next_tok 
      break if @lexer.tok_cur == ")"  
      args << @lexer.tok_cur 
    end
    @lexer.next_tok  
    body = parse_primary 
    raise "end expected..." unless @lexer.tok_cur == "end"
    @lexer.next_tok  
    AstFunction.new(id, args, body)
  end 


  def parse_primary 
    return case @lexer.tok_type
      when Lexer::TOK_NUMBER then parse_int
      when Lexer::TOK_IDENTIFIER then parse_identifier
      when Lexer::TOK_DEF then parse_definition
      when Lexer::TOK_PAREN then parse_paren 
    end
  end

end
