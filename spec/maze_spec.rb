require 'spec_helper'
require 'maze'

describe Maze do
  describe "build" do
    it "does something" do
      sample = "#I#\n#O#"
      maze = Maze.new(sample)
      maze.build.should([['#', 'I', '#'], ['#', 'O', '#']])
    end
  end
end