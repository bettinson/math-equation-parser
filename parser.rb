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
  @tokens = []

  def initiliaze(string)

  end

  def self.lex(string)
    # num is generally an empty string
    # until I find a number, then I keep appending to that
    # until it ends, then I add the number to the string
    num = ""
    for s in string
      case s
      when "+"
        @tokens << s
        @tokens << num unless num == ""
        num = ""
      when "-"
        @tokens << s << num
        @tokens << num unless num == ""
        num = ""
      when "*"
        @tokens << s
        @tokens << num unless num == ""
        num = ""
      when "/"
        @tokens << s
        @tokens << num unless num == ""
        num = ""
      when /\A\d+\z/
        num << s
      when "("
        @tokens << s
        @tokens << num unless num == ""
        num = ""
      when ")"
        tokens << s
        @tokens << num unless num == ""
        num = ""
      when "\n" #End of string
        tokens << s
      end
    end
  end
  return @tokens
end

class LexerTest < Test::Unit::TestCase
  def should_make_token_array
    assert ["(","1","+","1",")"] == Lexer.lex("(1+1)")
  end
end

def run_tests
  Test::Unit::UI::Console::TestRunner.run(LexerTest)
end

run_tests
