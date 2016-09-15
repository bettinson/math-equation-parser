require 'test/unit'
require 'test/unit/ui/console/testrunner'
require './lexer.rb'

class Token
  Plus     = 0
  Minus    = 1
  Multiply = 2
  Divide   = 3
  Number   = 4
  LParan   = 5
  RParan   = 6
  End      = 7

  attr_accessor :kind
  attr_accessor :value

  def initialize
    @kind = nil
    @value = nil
  end

  def unknown?
    @kind.nil?
  end
end

class LexerTest < Test::Unit::TestCase
  def test_simple_token_array
    assert_equal ["(","1","+","1",")"], Lexer.lex("(1+1)")
  end

  def test_complicated_token_arrays
    assert_equal ["(","1","+","(","1","+","2",")",")"], Lexer.lex("(1+(1+2))")
  end

  def test_complicated_token_arrays_with_space
    assert_equal ["(","1","+","(","1","+","2",")",")"], Lexer.lex("(1 +(1+2))")
  end

  def test_double_digit_numbers
    assert_equal ["(","12","+","1",")"], Lexer.lex("(12+1)")
    assert_equal ["(","1","+","(","1","+","22",")",")"], Lexer.lex("(1+(1+22))")
  end

  def test_exception_on_invalid_character
    assert_raise (Exception.new("Invalid character")) {Lexer.lex("m")}
  end
end

class ASTTest < Test::Unit::TestCase
  def setup
    @equation = '1 * 20 + 2 * 4'
  end

  def test_lex_is_lexed
    assert_equal ['1','*','20','+','2','*','4'], Lexer.lex(@equation)
  end

  #def test_root_node_is_of_class_node
  #  ast = AST.new(@equation)
  #  assert_equal ast.root_node.class, Node
  #end
end

def run_tests
  Test::Unit::UI::Console::TestRunner.run LexerTest
  Test::Unit::UI::Console::TestRunner.run ASTTest
end

run_tests

equation = "1 * 20 + 3 - 7"

ast = AST.new(equation)
puts ast.root_node.class
