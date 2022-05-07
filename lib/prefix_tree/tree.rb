require_relative './node'

module PrefixTree
  class Tree
    def initialize
      @root = nil
    end
   
    def values
      @root.values
    end

    def add(value)
      if @root
        added = @root.add_child(value)
      else
        added = Node.new(value: value)
        @root = added
      end
      raise 'Unable to add node' if added.nil?
      added.terminal = true
    end

    def values
      @root.values
    end

    def print
      @root.print
    end

  end
end
