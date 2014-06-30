class Formatter

	def clean(data)
		data = stripComments(data)
		data = stripWhitespace(data)

		return data
	end

	def stripComments(data)
		data.each_with_index do |line, index|
			test = line.match('//')
			unless test.nil?
				data[index] = line.gsub(/\/\/(.*)/, '')
			end
		end
		return data
	end

	def stripWhitespace(data)
		cleanedData = Array.new
		data.each do |line|
			unless line == "\n" || line.empty? || line == "\r" || line == " " || line.chomp.empty?
				cleanedData.push(line)
			end
		end
		data = cleanedData
		return data
	end		

end