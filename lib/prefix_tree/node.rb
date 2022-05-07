module PrefixTree
  class Node
    attr_accessor :children, :value, :terminal

    def initialize(value: nil, terminal: false)
      @children = []
      @value = value
      @terminal = terminal
    end

    def add_child(input)
      prefix = longest_common_prefix([input, self.value])
      added_node = nil
      if prefix.size > 0
        if input.size == prefix.size
          new_node = Node.new(value: self.value[prefix.size..-1], terminal: self.terminal)
          new_node.children = self.children
          self.value = input
          self.children = [new_node]
          added_node = self
        elsif prefix.size < input.size
          split_node = Node.new(value: self.value[prefix.size..-1], terminal: self.terminal)
          split_node.children = self.children

          self.value = prefix
          self.terminal = false
          added_node = Node.new(value: input[prefix.size..-1])
          self.children = [split_node, added_node]
          #self.value = prefix
          added_node.terminal = self.terminal
        else
          raise 'shouldnt be here'
        end
      else
        split_node = Node.new(value: self.value, terminal: self.terminal)
        self.value = ""
        self.terminal = false
        split_node.children = self.children
        added_node = Node.new(value: input)
        self.children = [ added_node, split_node ]
      end

      return added_node
    end

    def total_node_count
      return 0 if children.empty?
      children.sum { |c| c.total_node_count } + children.size
    end

    def print(tab = '')
      puts "#{tab}#{value}"

      next_tab = tab
      next_tab = "#{tab}  "
      children.each do |child|
        child.print(next_tab)
      end  
    end

    def values
      sub_vals = []
      sub_vals << self.value if terminal
      current_node = self
      nodes = []
      stack = [self]
      back_map = {}
      while !stack.empty?
        top = stack.pop
        nodes << top if top.terminal
        top.children.each do |child|
          back_map[child] = top
          stack.push child
        end
      end

      nodes.map(&:value)
    end

    def to_s
      "Node[#{value}]#{'*' if terminal}"
    end

    protected
    # thanks https://github.com/isisAnchalee/Algorithms/blob/master/Algorithms/Ruby/longest-common-prefix.rb
    def longest_common_prefix(strs)
      return '' if strs.empty?
      min, max = strs.minmax
      idx = min.size.times{ |i| break i if min[i] != max[i] }
      min[0...idx]
    end
  end
end
