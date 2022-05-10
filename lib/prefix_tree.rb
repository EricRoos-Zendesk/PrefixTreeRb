# frozen_string_literal: true

require_relative "prefix_tree/version"
require_relative "prefix_tree/tree"

module PrefixTree
  class Error < StandardError; end
  # Your code goes here...
  def self.new
    Tree.new
  end
end
