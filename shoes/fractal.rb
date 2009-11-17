class Fractal

   attr_reader :extent

   def initialize(x, y, angle=45, start_len =100,  extent=10, &block)
     @extent = extent
    draw_branch(x, y, angle, start_len, block)
   end

   def self.pol_2_cart(start_x, start_y, ang, dist)
    x = start_x + (dist * Math.cos(ang * 0.0174532925))
    y = start_y + (dist * Math.sin(ang * 0.0174532925))
    return [start_x, start_y, x,y]
  end

  def draw_branch(x, y, angle, len, block,  count=0)
    old_angle = angle
    x, y, angle, len = *block.call(x, y, angle, len, count)
    count = count + 1
    if count < @extent
      diff = angle - old_angle
      angle = (old_angle + diff) % 360
      alternate_angle = (old_angle - diff) % 360
      draw_branch(x, y, angle, len, block, count)
      draw_branch(x, y, alternate_angle, len, block, count)
    end
  end
end

Shoes.app do
  ITERATIONS = 12
  Fractal.new(300, 600, 270, 100 + (50 * rand), ITERATIONS) do |x, y, angle, len, count|
    coords = Fractal.pol_2_cart(x, y, angle, len)
    shade = (255 / ITERATIONS) * count
    stroke rgb(shade,shade, 125 + (shade / 2))
    nofill
    line *coords
    [coords[2], coords[3], angle + (45 * rand), len * 0.8]
  end
end
