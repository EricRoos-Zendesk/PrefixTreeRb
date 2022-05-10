require_relative './node'
require_relative './root_node'

module PrefixTree
  class Tree
    def initialize
      @root = RootNode.new
    end
   
    def values
      @root.values
    end

    def add(value)
      added = @root.add_child(value)
      added.terminal = true
      #puts "tree summary after adding #{value}"
      #print
      #puts "-----------\n"
    end

    def values
      @root.values.flatten
    end

    def print
      @root.print
    end

    def total_node_count
      @root.total_node_count
    end

  end
end
