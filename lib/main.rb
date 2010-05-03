require "ast/ex_ast"
require "ast/ast_binary"
require "ast/ast_call"
require "ast/ast_function"
require "ast/ast_integer"
require "ast/ast_variable"
require "lexer"
require "parser"

#puts "+" =~ /[a-z]/; exit(); 


lexer = Lexer.new
#lexer.start

parser = Parser.new(lexer)
parser.start




