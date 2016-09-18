require 'byebug'
require 'test/unit'
require 'test/unit/ui/console/testrunner'
require './lexer.rb'
require './ast.rb'
require './node.rb'

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
    @ast = AST.new(@equation)
  end

  def test_lex_is_lexed
    assert_equal ['1','*','20','+','2','*','4'], Lexer.lex(@equation)
  end

  def test_root_node_is_of_class_node
   assert_equal @ast.root_node.class, Node
  end

  def test_root_node_is_plus
    assert_equal @ast.root_node.value, '+'
  end

  def test_root_node_has_nodes
    assert_equal @ast.root_node.left.class, Node
  end

  def test_ast_left_side_is_correct
    assert_equal @ast.root_node.value, '+'
    assert_equal @ast.root_node.left.value, '*'
    assert_equal @ast.root_node.left.left, 1
    assert_equal @ast.root_node.left.right, 20
  end

  #def test_ast_right_side_is_correct
  #  puts "\n\n\n" + @ast.root_node.right + "\n\n\n"
  #  assert_equal @ast.root_node.right.value, '*'
  #  assert_equal @ast.root_node.right.left, 2
  #  assert_equal @ast.root_node.right.right, 4
  #end
end

def run_tests
  Test::Unit::UI::Console::TestRunner.run LexerTest
  Test::Unit::UI::Console::TestRunner.run ASTTest
end

