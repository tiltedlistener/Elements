class FileWriter 

	def initialize(file)
		@file = file
	end

	def write(data)
		File.open(@file, "w") do |f|  
			f.puts(data)
		end
	end	

end