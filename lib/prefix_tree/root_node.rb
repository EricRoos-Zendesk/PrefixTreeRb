require_relative './node'

module PrefixTree
  class RootNode < Node
    def initialize
      super(value: "")
    end

    def add_child(input)
      found_with_prefix = children.detect { |c| c.value[0] == input[0] }
      if found_with_prefix
        return found_with_prefix.add_child(input)
      else
        new_node = Node.new(value: input)
        children << new_node
        return new_node
      end
    end
  end
end
