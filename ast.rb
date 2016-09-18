require './lexer'

class AST
  attr_accessor :root_node

  def initialize (equation)
    @root_node = nil
    @pos = 0
    lexed = Lexer.lex(equation)
    construct_ast(lexed)
  end

  private
  def construct_ast(lexed)
    @root_node = parse_pm(lexed)
  end

  def parse_pm(lexed)
    left = parse_md(lexed)
    @pos += 1
    char = lexed[@pos]
    if char == '+'
      node = Node.new(left, parse_pm(lexed[1..-1]), '+')
      return node
    elsif char == '-'
      node = Node.new(left, parse_pm(lexed[1..-1]), '-')
      return node
    else
      @pos -= 1
      return left
    end
  end

  def parse_md(lexed)
    left = parse_literal(lexed)
    @pos += 1
    char = lexed[@pos]
    if char == '*'
      node = Node.new(left, parse_md(lexed[@pos..-1]), '*')
      return node
    elsif char == '/'
      node = Node.new(left, parse_md(lexed[@pos..-1]), '/')
      return node
    else
      @pos -= 1
      return left
    end
  end

  # Look for close paranthesis in parse_pm
  # Look for open here
  def parse_literal(lexed)
    char = lexed[@pos]
    if char =~ /\A\d+\z/
      return char.to_i
    else
      raise Exception.new("Invalid character: " + char)
    end
  end
end
