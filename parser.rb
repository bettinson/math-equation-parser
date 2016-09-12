require 'test/unit'
require 'test/unit/ui/console/testrunner'

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

class AST
end

class Lexer
  def self.lex(string)
    # num is generally an empty string
    # until I find a number, then I keep appending to that
    # until it ends, then I add the number to the string
    tokens = []
    num = ""
    string.split("").each do |s|
      case s
      when '+'
        tokens << num unless num == ""
        tokens << s
        num = ""
      when '-'
        tokens << num unless num == ""
        tokens << s << num
        num = ""
      when '*'
        tokens << num unless num == ""
        tokens << s
        num = ""
      when "/"
        tokens << num unless num == ""
        tokens << s
        num = ""
      when /\A\d+\z/
        num << s
      when '('
        tokens << num unless num == ""
        tokens << s
        num = ""
      when ')'
        tokens << num unless num == ""
        tokens << s
        num = ""
      when '\0' #End of string
        tokens << s
      else
        raise Exception.new("Invalid character")
      end
    end
    return tokens
  end
end

class LexerTest < Test::Unit::TestCase
  def test_simple_token_array
    assert_equal ["(","1","+","1",")"], Lexer.lex("(1+1)")
  end

  def test_complicated_token_arrays
    assert_equal ["(","1","+","(","1","+","2",")",")"], Lexer.lex("(1+(1+2))")
  end

  def test_double_digit_numbers
    assert_equal ["(","12","+","1",")"], Lexer.lex("(12+1)")
    assert_equal ["(","1","+","(","1","+","22",")",")"], Lexer.lex("(1+(1+22))")
  end

  def test_exception_on_invalid_character
    assert_raise (Exception.new("Invalid character")) {Lexer.lex("m")}
  end
end

def run_tests
  Test::Unit::UI::Console::TestRunner.run LexerTest
end

run_tests
