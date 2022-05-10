module PrefixTree
  class Node
    attr_accessor :children, :value, :terminal, :id, :previous

    def initialize(value: nil, terminal: false)
      @children = []
      @value = value
      @terminal = terminal
      @id = (rand() * 100000).to_i
      @previous = nil
    end

    def add_child(input)
      common_prefix = longest_common_prefix([self.value, input])
      if common_prefix.size > 0
        suffix = self.value[common_prefix.size..-1]
        previously_terminal = self.terminal

        self.value = common_prefix
        unless self.terminal && suffix.size == 0
          self.terminal = false
        end
        if suffix.size > 0
          new_node = Node.new(value: suffix, terminal: previously_terminal)
          new_node.children = self.children
          self.children = [ new_node ]
          #add suffix to base node with prefix value
          input_suffix = input[common_prefix.size..-1]
          new_node = Node.new(value: input_suffix)

          found_with_prefix = children.detect { |c| c.value[0] == input_suffix[0] }
          if found_with_prefix
            return found_with_prefix.add_child(input_suffix)
          else
            new_node = Node.new(value: input_suffix)
            children << new_node
          end
          return new_node
        else
          input_suffix = input[common_prefix.size..-1]
          found_with_prefix = children.detect { |c| c.value[0] == input_suffix[0] }
          if found_with_prefix
            return found_with_prefix.add_child(input_suffix)
          else
            new_node = Node.new(value: input_suffix)
            children << new_node
          end
          return new_node
        end
      else
        new_node = Node.new(value: input)
        children << new_node
        return new_node
      end
    end

    def total_node_count
      count = 0
      nodes = []
      stack = [self]
      while !stack.empty?
        top = stack.pop
        count = count + 1 if top.value.size > 0
        top.children.each do |child|
          stack.push child
        end
      end
      count
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
      if self.terminal
        if children.size > 0
          return children.map { |c| c.values.map{ |val| "#{self.value}#{val}" } }.flatten + [self.value]
        else
          return [self.value]
        end
      else
        return children.map { |c| c.values.map{ |val| "#{self.value}#{val}" }.flatten }.flatten
      end
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
