class Node
  attr_accessor :left
  attr_accessor :right
  attr_accessor :value

  def initialize(left, right, value)
    @left = left
    @right = right
    @value = value
  end
end
