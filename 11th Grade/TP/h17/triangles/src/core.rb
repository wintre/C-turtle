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

	private :line_len
end

loop do
	b = binding
	print "> "; input = gets.chomp
	b.eval input
end

#points = Array.new
#lines = Array.new
#triangles = Array.new
#loop do
#	print "> "
#	input = gets.chomp
#	if input.match (/p [0-9]+ [0-9]+/)
#		x, y = input.scan(/\d/).map {|x| x.to_i} 
#		point = Point.new x, y
#		points.push point
#		points.last.dump
#		puts
#	elsif input.match (/l [0-9]+ [0-9]+/)
#		p1, p2 = input.scan(/\d/).map {|x| x.to_i} 
#		line = Line.new points[p1], points[p2]
#		lines.push line
#		lines.last.dump
#		puts
#	elsif input.match (/t [0-9]+ [0-9]+/)
#		l1, l2, l3 = input.scan(/\d/).map {|x| x.to_i} 
#		triangle = Triangle.new lines[l1], lines[l2], lines[l3]
#		triangles.push triangle
#		triangles.last.dump
#		puts
#	elsif input.match (/pt [0-9]+/)
#		n = input.scan(/\d/)[0].to_i
#		t = triangle[n]
#		puts lineSize(t.l1.p1, t.l1.p2) + lineSize(t.l2.p1, t.l2.p2) + lineSize(t.l3.p1, t.l3.p2)	
#	end
#end
