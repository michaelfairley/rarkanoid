class Paddle
  WIDTH = 80

  attr_reader :x

  def initialize
    @x = Rarkanoid::WIDTH/2
  end

  def move(direction)
    raise unless [:left, :right].include?(direction)
    amount = 6
    amount *= -1  if direction == :left
    @x += amount
    if @x < WIDTH/2
      @x = WIDTH/2
    end
    if @x > Rarkanoid::WIDTH - WIDTH/2
      @x = Rarkanoid::WIDTH - WIDTH/2
    end
  end

  def hit?(ballx)
    if ballx > @x - WIDTH/2 && ballx < @x + WIDTH/2
      (ballx - x1) / WIDTH.to_f
    else
      false
    end
  end

  def x1
    @x - WIDTH/2
  end

  def x2
    @x + WIDTH/2
  end

  def y1
    Rarkanoid::HEIGHT - 32
  end

  def y2
    Rarkanoid::HEIGHT - 16
  end

  def draw(window)
    color = Gosu::Color::GRAY

    window.draw_quad(x1, y1, color, x2, y1, color, x2, y2, color, x1, y2, color)
  end
end
