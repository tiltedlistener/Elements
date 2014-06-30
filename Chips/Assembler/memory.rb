module Memory

	def self.testForMemory(line)
		test = line.match('@')

		if test.nil?
			return false
		else
			return true
		end
	end

	def self.convertDecimalMemoryToAddress(line)
		decimal = line.match(/\d+/)[0].to_i
		directBinary = decimal.to_s(2)
		len = directBinary.length
		zeroPadding = 15-len
		
		i=0
		while(i<=zeroPadding)
			directBinary = "0" + directBinary
			i+=1
		end
		return directBinary
	end

end