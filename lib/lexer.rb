class Lexer

  attr_accessor :tok_cur, :tok_type 

  TOK_DEF = -1
  TOK_IDENTIFIER = -2
  TOK_NUMBER = -3
  TOK_PAREN = -4
  
  
  def initialize(inline_src = "")
    @source = ""
    @cache = "" 
    if inline_src != ""
      @source = inline_src 
    else 
      read_input("source.ocl") 
    end
    @pos = -1
  end


  def start 
    puts "starting lexer..."
    while true
      puts "t #{next_tok} type: #{tok_type}"
    end
  end
  
  
  def next_tok 
    @tok_cur = ""
    while (@c = next_char)
      next if whitespace?

      if @c =~ /[a-zA-Z]/
        @tok_cur = @c 
        while (@c = next_char) =~ /[a-zA-Z0-9]/
          @tok_cur += @c
        end
        @pos -= 1
        if @tok_cur == "def"
          @tok_type = TOK_DEF
          return @tok_cur
        else
          @tok_type = TOK_IDENTIFIER
          return @tok_cur 
        end
      end

      if @c =~ /[0-9]/
        @tok_cur = @c
        while (@c = next_char) =~ /[0-9]/
          @tok_cur += @c
        end
        @pos -= 1
        @tok_type = TOK_NUMBER 
        return @tok_cur.to_i 
      end

      if @c == "("
        @tok_cur = @c
        @tok_type = TOK_PAREN
        return @c
      end
      unless whitespace? or @c == "" or @c == ","
        @tok_type = TOK_IDENTIFIER
        @tok_cur = @c 
        return @tok_cur
      end
      
    end
  end


  private 


  def whitespace?
    @c == "\t" or @c == "\n" or @c == "\r" or @c == " "
  end

  def token_type 
    return TOK_DEF if @tok_cur == "def" 
    return TOK_NUMBER if @tok_cur.is_a?(Integer)
    return TOK_IDENTIFIER 
  end 


  def read_input(file) 
    open(file) do |f|
      f.each_line do |line|
        @source += line 
      end
    end
    @source += " "
  end


  def next_char 
    if @pos <= @source.length-1
      @pos += 1 
      c = @source.slice(@pos, 1)
      # puts "char: #{c}"
      c
    else 
      exit 
    end
  end

end



