Array.class_eval do
	def to_hash
		Hash[self]
	end

	def index_by
		Hash[self.map {|x| [yield(x), x]}]
	end

	def subarray_count subarray
		count = 0
		self.each_cons(subarray.count) {|x| count += 1 if x == subarray}
		count
	end

	def occurances_count
		occurances = Hash[self.uniq.map {|x| a.select {|y| x == y}}.map {|z| [z.first, z.count]}]
		occurances.default = 0
		occurances
	end

	def densities
		self.map {|x| self.select {|y| x == y}}.map {|z| z.count}
	end
end
