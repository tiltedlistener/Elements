# Main class to build XML for output

# This class is handed a block of code
# finds keywords and then builds out their XML
# 
# @param code
# block of code to format
#
# @return
# Formatted XML

class Builder 

	@@keywords = [
		"class", 
		"constructor",
		"function",
		"method",
		"field",
		"static",
		"var",
		"int", 
		"char",
		"boolean",
		"void",
		"true",
		"false",
		"null",
		"this",
		"let",
		"do",
		"if",
		"else",
		"while",
		"return"
	]

	@@symbols = [
		"{",
		"}",
		"(",
		")",
		"[",
		"]",
		".",
		",",
		";",
		"+",
		"-",
		"*",
		"/",
		"&",
		"|",
		"<",
		">",
		"=",
		"~"
	]	

	# Walk through code methods
	def initialize(code)
		@rawCode = code
		@formattedCode = []

		# For matching code blocks
		@linePosition = 0
		@linePositionOffset = 0
		@curlyCount = 0
	end

	def getFormattedXML
		return @formattedCode.join("\n")
	end	

	# Code reading methods
	def process
		puts "Processing: " + self.class.name
		setupCurrentNode
		len = @rawCode.length
		while @linePosition < len do
			res = self.testForKeyword(@rawCode[@linePosition])
			@linePosition += 1
		end
		closeCurrentNode	
		return self.getFormattedXML
	end

	def testForKeyword(line)
		len = @@keywords.length
		i = 0
		while i < len do
			test =line.match(@@keywords[i])
			unless test.nil?
				switchByTag(test[0], line)
				break
			end
			i+=1
		end
		return true
	end

	def switchByTag(tag, line) 
		setupProcessLoop(line)
		result = ''
		case tag
			when "class"
				section = self.fetchCodeBlock
				obj = Class_Builder.new(section.code)
				obj.setName(line)
				result = obj.process
				@linePosition = section.offset+1
			when "constructor"
	
			when "function"
				section = self.fetchCodeBlock
				obj = Fn_Builder.new(section.code)
				obj.setReturnType(line)						
				obj.setName(line)
				result = obj.process		
				@linePosition = section.offset+1		
			when "method"
			
			when "field"
			
			when "static"
			
			when "var"
				obj = Var_Builder.new(line)
				result = obj.build
				@linePosition +=1					
			when "int" 
			
			when "char"
			
			when "boolean"
			
			when "void"
			
			when "true"
			
			when "false"
			
			when "null"
			
			when "this"
			
			when "let"
			
			when "do"

			when "if"
			
			when "else"
			
			when "while"
			
			when "return"
				obj = Return_Builder.new(line)
				result = obj.build
				@linePosition +=1	
			end

		@formattedCode.push(result)
	end

	def fetchCodeBlock

		# Line position stays fixed
		@linePositionOffset = @linePosition
		@curlyCount = 0

		# Find the first curly bracket on the first or second line
		if (!@rawCode[@linePositionOffset].match("{").nil?)
			# Matches for the same row
			unless (@rawCode[@linePositionOffset].match("}").nil?)
				return []
			else
				@curlyCount += 1
			end
		elsif (!@rawCode[@linePositionOffset + 1].match("{").nil?)
			# Matches for the same row			
			unless (@rawCode[@linePositionOffset + 1].match("}").nil?)
				return []
			else 
				@curlyCount += 1
				@linePositionOffset +=1
				topOffset += 1
			end
		else
			raise "Method / function / class parse error on curly bracket. Line: " + @linePositionOffset
		end
	
		# Go through until we're done to zero on curly count
		while (@curlyCount > 0) do
			@linePositionOffset +=1
			cur = @rawCode[@linePositionOffset]	
			unless cur.match("}").nil?
				@curlyCount -= 1
			else 
				unless cur.match("{").nil?
					@curlyCount += 1
				end
			end
		end

		# Your offset is wrong in there - you need to hand it the whole function in order to get parameters
		result = CodeGroup.new(@rawCode.slice(@linePosition + 1, @linePositionOffset-1), @linePositionOffset)
		return result
	end	

	def addTag(name, value) 

		tag = "<" + name + ">" + value + "</" + name + ">"
		@formattedCode.push(tag.strip)
	end

	def addOpeningTag(name) 
		@formattedCode.push("<" + name + ">")
	end

	def addClosingTag(name)
		@formattedCode.push("</" + name + ">")
	end


	# Stub methods for child classes to override
	def setupCurrentNode
		# Opens up current node
	end

	def closeCurrentNode
		# Closes the tag
	end

	def setupProcessLoop(line)
		# run method at the start of every process loop
	end

end