class Ball
  SIZE = 8

  attr_reader :dx, :dy

  def initialize(paddle, blocks)
    @paddle = paddle
    @blocks = blocks
    @x = paddle.x
    @y = 440
    @dx = 2.0
    @dy = -2.0
  end

  def x
    @x.to_i
  end

  def y
    @y.to_i
  end

  def lower_bound
    480-32
  end

  def lost?
    @y > lower_bound
  end

  def speed
    @dx.abs + @dy.abs
  end

  def move
    left_bound = SIZE/2
    upper_bound = SIZE/2
    right_bound = Rarkanoid::WIDTH - SIZE/2

    old_x = @x
    old_y = @y

    @x += @dx
    if @x < left_bound
      @x = left_bound
      @dx *= -1
    end
    if @x > right_bound
      @x = right_bound
      @dx *= -1
    end

    @y += @dy
    if @y < upper_bound
      @y = upper_bound
      @dy *= -1
    end
    if @y > lower_bound
      if where = @paddle.hit?(@x)
        @y = lower_bound
        @dy *= -1

        @dx, @dy = new_velocity(where, speed+0.1)
      end
    end

    @blocks.each do |block|
      if block.contains?(self)
        block.hit!

        if old_y < block.y1
          @y -= (@y - block.y1)
          @dy *= -1
        elsif old_y > block.y2
          @y += (block.y2 - @y)
          @dy *= -1
        elsif old_x < block.x1
          @x -= (@x - block.x1)
          @dx *= -1
        elsif old_x > block.x2
          @x += (block.x2 - @x)
          @dx *= -1
        else
          raise
        end
      end
    end
  end

  def new_velocity(where, speed)
    @heading = case where
               when 0.0..0.25
                 [-0.75, -0.25]
               when 0.25..0.50
                 [-0.25, -0.75]
               when 0.50..0.75
                 [0.25, -0.75]
               when 0.75..1.0
                 [0.75, -0.25]
               else
                 raise
               end
    @heading.map{|h| h*speed }
  end

  def x1
    x - SIZE/2
  end

  def x2
    x + SIZE/2
  end

  def y1
    y - SIZE/2
  end

  def y2
    y + SIZE/2
  end

  def draw(window)
    color = Gosu::Color::WHITE

    window.draw_quad(x1, y1, color, x2, y1, color, x2, y2, color, x1, y2, color)
  end
end
