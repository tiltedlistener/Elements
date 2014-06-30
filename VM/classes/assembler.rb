# Assembler.rb
# 
# Class to generate Assembly code from VM Hack language
require 'rubygems'
require_relative 'file/filereader'
require_relative 'file/filewriter'
require_relative 'file/formatter'
require_relative 'codegenerator'

class Assembler 

	def initialize(input, output)
		if testForEmpty(input, output)
			@data = Array.new
			@fileWriter = FileWriter.new(output)
			@codeWriter = CodeGenerator.new
			formatter = Formatter.new			

			if testForFileOrDirectory(input)
				@data = formatter.clean(@data)
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

		# We assume we need a Bootstrap
		@data.concat(["call Sys.init 0"])

		while i < len do 
			getDataFromFile(vms[i])
			i += 1
		end
	end

	def getDataFromFile(name)
		reader = FileReader.new(name)
		@data.concat(reader.getData)
	end


	# Code Generation Methods
	def createCode
		@codeWriter.setData(@data)
		@codeWriter.translate
		@codeWriter.createAssembly
		@finalData = @codeWriter.getData
	end

	# File Creation Methods
	def writeFile 
		@fileWriter.write(@finalData)
	end

end