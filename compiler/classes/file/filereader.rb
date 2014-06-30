class FileReader 
	
	def initialize(file)
		@file = file
		@rawData = Array.new
		readFile
	end

	def readFile
		File.open("#{@file}", "r").each_line do |line|
		 	@rawData.push(line)
		end
	end

	def getData 
		return @rawData
	end

end