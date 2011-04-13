class Maze
  def solve(maze)
    matrix = maze.split('\n')
  end

  def build(maze)
    maze.split(%r{\n}m).reduce([]) {|acc, s| acc << s.chars.to_a; acc}
  end

  def fake(maze)
    'S'
  end
end
