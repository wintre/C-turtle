require 'simplecov'
SimpleCov.start
require Dir.pwd + '/src/core'
require 'minitest/autorun'

class TemplateTest < MiniTest::Unit::TestCase
	def setup() 
		@p1, @p2, @p3 = Point.new(1,1), Point.new(4,1), Point.new(1,5)
		@t = Triangle.new @p1, @p2, @p3
	end

	def test_create_triangle
		assert_equal @t.p1, @p1
		assert_equal @t.p2, @p2
		assert_equal @t.p3, @p3
	end

	def test_perimeter
		assert_equal 12, @t.perimeter
	end

	def test_face
		assert_equal 6, @t.face
	end

	def test_angle
		assert_equal 90, @t.angle(@p3, @p1, @p2)
	end

	def test_angles
		alfa, beta, gamma = @t.angles
		assert_equal 90, gamma 
	end
end
