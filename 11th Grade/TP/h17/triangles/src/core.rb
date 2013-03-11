class Point
	attr_reader :x, :y

	def initialize x, y
		@x, @y = x, y
	end
end

class Triangle
	attr_reader :p1, :p2, :p3
	Pi = Math::PI

	def initialize p1, p2, p3
		@p1, @p2, @p3 = p1, p2, p3
	end

	def line_len p1, p2
		Math.sqrt(((p2.x - p1.x) ** 2) + ((p2.y - p1.y) ** 2))
	end

	def perimeter
		line_len(@p1, @p2) + line_len(@p1, @p3) + line_len(@p2, @p3)
	end

	def face
		hp = perimeter/2
		Math.sqrt(hp * (hp-line_len(@p1, @p2))*(hp-line_len(@p1, @p3))*(hp-line_len(@p2, @p3)))
	end

	def angle p1, p2, p3
		cos = -(line_len(p1, p3)**2-line_len(p1, p2)**2-line_len(p2, p3)**2)
		cos /= 2*line_len(p1,p2)*line_len(p2,p3)
		180*Math.acos(cos)/Math::PI
	end

	def angles
		return angle(@p1, @p2, @p3), angle(@p1, @p3, @p2), angle(@p2, @p1, @p3)
	end

	def bisector p1, p2, p3
		angle(p1, p2, p3)/2
	end

	private :line_len
end
