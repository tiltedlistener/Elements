class Fn_Builder < Builder

	@@returnTypes = [
		'void',
		'int',
		'char', 
		'boolean'
	];

	def setupCurrentNode
		@formattedCode.push("<subroutineDec>")
		self.addTag("keyword", "function")
		self.addTag("keyword", @returnType)	
		self.addTag("identifier", @fnName)			
		self.writeParameterData		
		self.addOpeningTag('subroutineBody')
		self.addTag("symbol", "{")

		@buildStatement = true
	end

	def closeCurrentNode
		self.addClosingTag("statements")
		self.addTag("symbol", "}")
		self.addClosingTag('subroutineBody')
		@formattedCode.push("</subroutineDec>")
	end

	def setupProcessLoop(line)
		if line.match('var').nil? && @buildStatement
			self.addOpeningTag("statements")
			@buildStatement = false
		end
	end	

	def setName(line)
		line = line.gsub(@returnType, '').strip
		line = line.gsub("function ", '').strip
		line = line.gsub("{", "").strip
		line = line.gsub("}", "").strip

		@parameterBlock = getParameterBlock(line)
		line = line.gsub(@parameterBlock, '')
		@fnName = line
	end

	def setReturnType(line)
		len = @@returnTypes.length
		i = 0
		while i < len do
			test =line.match(@@returnTypes[i])
			unless test.nil?
				@returnType = test[0]
				break
			end
			i+=1
		end
	end

	def getParameterBlock(line)
		return /\((.+?)\)/.match(line)[0]
	end

	def writeParameterData
		self.addTag("symbol", "(")
		self.addOpeningTag("parameterlist")

		@parameterBlock.delete! "()"
		tempParameters = @parameterBlock.split(',')

		i = 0
		len = tempParameters.length
		while i < len do 
			paramArray = tempParameters[i].split
			keyword = paramArray[0].strip
			identifier = paramArray[1].strip

			self.addTag("keyword", keyword)
			self.addTag("identifier", identifier)
			i+=1
		end

		self.addClosingTag("parameterlist")
		self.addTag("symbol", ")")
	end

end