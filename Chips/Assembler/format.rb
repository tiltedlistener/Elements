module Formatter

	@@fileData = Array.new
	@@rawData = Array.new

	@@symbols = Hash.new

	def self.stripComments
		@@rawData.each_with_index do |line, index|
			test = line.match('//')
			unless test.nil?
				@@rawData[index] = line.gsub(/\/\/(.*)/, '')
			end
		end
	end

	def self.stripWhitespace
		cleanedData = Array.new
		@@rawData.each do |line|
			unless line == "\n" || line.empty? || line == "\r" || line == " " || line.chomp.empty?
				cleanedData.push(line)
			end
		end
		@@rawData = cleanedData
	end

	def self.testForSymbol(line)
		line = line.gsub(/@/,'').strip
		result = @@symbols[line]

		if result.nil?
			return false
		else
			return result.to_s
		end
	end

	def self.addToBody(line)
		line = line.strip
		unless line.nil?
			unless line.empty?
				@@fileData.push(line)
			end
		end
	end

	def self.addToRawBody(line)
		@@rawData.push(line)
	end

	def self.readRaw
		return @@rawData
	end

	def self.readBody
		return @@fileData
	end

	def self.identifySymbols
		# locate symbols
		@@rawData.each_with_index do |line, index|
			test = line.match(/\(/)
			unless test.nil?
				line = line.gsub(/\(/, '')
				line = line.gsub(/\)/, '')
				line = line.strip

				@@symbols[line] = index
				@@rawData[index] = ''
			end
		end
	end

	def self.testForPredefined(line)
		line = line.gsub(/@/,'').strip

		case line
			when "SCREEN"
				result = "16384"
			when "address"
				result = "17"
			when "counter"
				result = "16"
			when "SP"
				result = "0"
			when "LCL"
				result = "1"
			when "ARG"
				result = "2"
			when "THIS"
				result = "3"
			when "THAT"	
				result = "4"
			when "KBD"
				result = "24576"
			else
				result = false
		end

		unless result 
			line.match("R")
			unless line.nil?
				line = line.gsub(/R/, '')
				result = line.to_s
			end
		end

		return result
	end

end