# compiler.rb
# 
# Class to generate Assembly code from VM Hack language
require 'rubygems'
Dir[File.dirname(__FILE__) + "/file/*.rb"].each{ |file| require_relative file }
Dir[File.dirname(__FILE__) + "/collaborators/*.rb"].each{ |file| require_relative file }
Dir[File.dirname(__FILE__) + "/builders/*.rb"].each{ |file| require_relative file }

class Compiler

	def initialize(input, output)

		if testForEmpty(input, output)
			@data = Array.new
			@fileWriter = FileWriter.new(output)	
			formatter = Formatter.new	

			if testForFileOrDirectory(input)
				@data = formatter.clean(@data)
				builder = Builder.new(@data)
				result = builder.process

				@fileWriter.write(result)
			end
		else
			puts "ERROR: One or more inputs empty"
		end
	end

	# Data Fetching and Merging Methods
	def testForEmpty(one, two)
		if one.nil? || two.nil? || one.strip.empty? || two.strip.empty? 
			return false
		else
			return true
		end
	end

	def testForFileOrDirectory(name)
		if File.directory?(name)
			getFilesFromDirectory(name)
		elsif File.file?(name)
			getDataFromFile(name)
		else
			puts "ERROR: Directory or File does not exist"
			return false
		end
		return true
	end

	def getFilesFromDirectory(name)
		vms = Dir["#{name}/*.vm"]
		len = vms.length
		i = 0

		while i < len do 
			getDataFromFile(vms[i])
			i += 1
		end
	end

	def getDataFromFile(name)
		reader = FileReader.new(name)
		@data.concat(reader.getData)
	end


	# File Creation Methods
	def writeFile 
		@fileWriter.write(@finalData)
	end

end