class Lexer
  def self.lex(string)
    # num is generally an empty string
    # until I find a number, then I keep appending to that
    # until it ends, then I add the number to the string
    tokens = []
    num = ""
    string.split('').select { |c| c!= ' '}.each do |s|
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
        tokens << num unless num == ""
        tokens << s
        num = ""
      else
        raise Exception.new("Invalid character")
      end
    end
    tokens << num unless num == ""
    return tokens
  end
end
