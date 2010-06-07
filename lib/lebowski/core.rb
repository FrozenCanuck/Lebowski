module Lebowski
  
  class Rect

    attr_accessor :width, :height, :x, :y
    
    def initialize(width, height, x, y)
      @width = width
      @height = height
      @x = x
      @y = y
    end
    
    def to_s()
      return "Rect<width: #{width}, height: #{height},  x: #{x}, y: #{y}>"
    end

  end
  
  class Coords

    attr_accessor :x, :y
    
    def initialize(x, y)
      @x = x
      @y = y
    end
    
    def to_s()
      return "Coords<x: #{x}, y: #{y}>"
    end
  
  end
  
end