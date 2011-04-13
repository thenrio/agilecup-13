require 'typhoeus'
require 'yajl'
require 'rack/utils'
require 'maze'


class Game
  attr_accessor :key
  attr_accessor :question
  attr_accessor :expiry
  def initialize
    self.key = 'vCYVFJtCSDEbKt9eqPIacQ%3D%3D'
    self.question = 1
  end

  def instructions
    url = "http://beta.agilecup.org/problem/0#{question}?key=#{key}"
    url = "#{url}&#{expiry}" if expiry
    Typhoeus::Request.get(url)
  end

  def post_url
    "http://beta.agilecup.org/solution/0#{question}"
  end

  def solve(solution)
    body = "solution=#{solution}&key=vCYVFJtCSDEbKt9eqPIacQ%3D%3D"
    post = Typhoeus::Request.post(post_url, :body => body)
    puts "=============POST #{post_url} => #{body}"
    json = Yajl::Parser.new.parse(post.body)
  end

  def start
    maze = Yajl::Parser.new.parse(instructions.body)
    puts "=============GET\n#{maze}"
    solution = Maze.new.solve(maze)
    response = solve(solution)
    if(response['success'] == 'ok')
      self.question += 1
      self.expiry = response['expiry']
      start
    else
      puts "failed"
    end
  end
end

