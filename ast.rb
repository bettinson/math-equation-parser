require './lexer'
require 'byebug'

class AST
  attr_accessor :root_node

  def initialize (equation)
    @root_node = nil
    @pos = 0
    @debugging = false
    lexed = Lexer.lex(equation)
    construct_ast(lexed)
  end

  private
  def construct_ast(lexed)
    if @debugging
      byebug
    end
    @root_node = parse_pm(lexed)
  end

  def parse_pm(lexed)
    if @debugging
      byebug
    end

    left = parse_md(lexed)
    char = lexed[@pos]
    @pos += 1
    if char == '+'
      node = Node.new(left, parse_pm(lexed), '+')
      return node
    elsif char == '-'
      node = Node.new(left, parse_pm(lexed), '-')
      return node
    else
      @pos -= 1
      return left
    end
  end

  def parse_md(lexed)
    if @debugging
      byebug
    end

    left = parse_literal(lexed)
    char = lexed[@pos]
    @pos += 1
    if char == '*'
      node = Node.new(left, parse_md(lexed), '*')
      return node
    elsif char == '/'
      node = Node.new(left, parse_md(lexed), '/')
      return node
    else
      @pos -= 1
      return left
    end
  end

  # Look for close paranthesis in parse_pm
  # Look for open here
  def parse_literal(lexed)
    if @debugging
      byebug
    end

    char = lexed[@pos]
    @pos += 1
    if char =~ /\A\d+\z/
      return char.to_i
    else
      raise Exception.new("Invalid character: " + char)
    end
  end
end
