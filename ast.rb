requite './lexer'

class AST
  @root_node = nil

  attr_accessor :root_node

  def initialize (equation)
    lexed = Lexer.lex(equation)
    construct_ast(lexed)
  end

  private
  def construct_ast(lexed)
    @root_node = parse_pm(lexed)
  end

  def parse_pm(lexed)
    left = parse_md(lexed)
    char = lexed[0]
    if char == '+'
      node = Node.new(left, parse_pm(lexed[1..-1]), '+')
      return node
    elsif char == '-'
      node = Node.new(left, parse_pm(lexed[1..-1]), '-')
      return node
    else
      # Stopping here
      puts("Hey")
      parse_md(lexed)
    end
  end

  def parse_md(lexed)
    left = parse_literal(lexed)
    char = lexed[0]
    if char == '*'
      node = Node.new(left, parse_pm(lexed[1..-1]), '*')
      return node
    elsif char == '/'
      node = Node.new(left, parse_pm(lexed[1..-1]), '/')
      return node
    else
      return parse_literal(lexed)
    end
  end

  def parse_literal(lexed)
    char = lexed[0]
    if char =~ /\A\d+\z/
      return char.to_i
    else
      raise Exception.new("Invalid character: " + char)
    end
  end
end
