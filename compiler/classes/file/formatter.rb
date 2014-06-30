class Formatter

	def clean(data)
		data = stripComments(data)
		data = stripWhitespace(data)

		return data
	end

	def stripComments(data)
		# Strip // comments
		data.each_with_index do |line, index|
			test = line.match('//')
			unless test.nil?
				data[index] = line.gsub(/\/\/(.*)/, '')
			end
		end

		# Strip /* */ style comments
		data.each_with_index do |line, index|
			test = /\/\*(.*)\*\//.match(line)
			unless test.nil?
				data[index] = line.gsub(/\/\*(.*)\*\//, '').strip
			end
		end		

		# Strip multi-line comments
		comment_start = false
		comment_end = false
		data.each_with_index do |line, index|
			testStart = /\/\*/.match(line)
			testEnd = /\*\//.match(line)
			unless testStart.nil?
				comment_start = index
			end

			unless testEnd.nil?
				comment_end = index
				
				i = comment_start
				while i<=comment_end do 
					data[i] = ''
					i += 1
				end

				comment_start = comment_end = false
			end
		end		

		return data
	end

	def stripWhitespace(data)
		cleanedData = Array.new
		data.each do |line|
			unless line == "\n" || line.empty? || line == "\r" || line == " " || line.chomp.empty? || line == "\r\n"
				cleanedData.push(line)
			end
		end
		data = cleanedData
		return data
	end		

end