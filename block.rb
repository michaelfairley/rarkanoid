class Block
  attr_reader :x, :y, :type, :destroyed

  def initialize(x, y, type)
    @x = x
    @y = y
    @type = type
    @destroyed = false
  end

  def x1
    Rarkanoid::BLOCK_WIDTH * x + Rarkanoid::BLOCK_PADDING
  end

  def x2
    Rarkanoid::BLOCK_WIDTH * (x+1) - Rarkanoid::BLOCK_PADDING
  end

  def y1
    Rarkanoid::BLOCK_HEIGHT * y + Rarkanoid::BLOCK_PADDING
  end

  def y2
    Rarkanoid::BLOCK_HEIGHT * (y+1) - Rarkanoid::BLOCK_PADDING
  end

  def contains?(ball)
    ball.x >= x1 && ball.x <= x2 && ball.y >= y1 && ball.y <= y2
  end

  def hit!
    @destroyed = true
  end

  def color
    case type
    when :aqua
      Gosu::Color::AQUA
    when :red
      Gosu::Color::RED
    when :green
      Gosu::Color::GREEN
    when :blue
      Gosu::Color::BLUE
    when :yellow
      Gosu::Color::YELLOW
    when :fuchsia
      Gosu::Color::FUCHSIA
    when :cyan
      Gosu::Color::CYAN
    when :gray
      Gosu::Color::GRAY
    else raise
    end
  end

  def draw(window)
    window.draw_quad(x1, y1, color, x2, y1, color, x2, y2, color, x1, y2, color)
  end
end
