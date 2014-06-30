require_relative "builders/classbuilder"


class LexicalSpotter

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

	def initialize

	end

	def testIfInteger(num) 
		return (num.to_i > 0 && num.to_i < 32768)
	end

	def findKeywords(data)
		len = data.length
		i = 0
		while i < len do
			self.testForKeyword(data[i])
			i+=1
		end
	end

	def testForKeyword(line)
		len = @@keywords.length
		i = 0
		while i < len do
			test =line.match(@@keywords[i])
			unless test.nil?
				if (test[0] == 'class')
					classBuilder = Class_Builder.new(line)
				end
				break
			end
			i+=1
		end
	end

	def buildClass(line)
		# Clean up the standards
		line = line.gsub("class ", '')
		line = line.gsub(" {", '').strip


		
	end

end