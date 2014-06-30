class Var_Builder < Builder

	def build
		self.addOpeningTag("varDec")
		self.addTag("keyword", "var")

		# Remove var and ';'
		line = @rawCode.gsub("var", '').strip
		line = line.gsub(";", '')

		# Get variable type and setup array
		lineArray = line.split(" ")
		self.addTag("identifier", lineArray[0])
		len = lineArray.length
		lineArray = lineArray[1..len]

		# Test if we have more than one variable
		i = 0
		while i < len-1 do
			cur = lineArray[i]			
			self.addTag("identifier", cur.gsub(",",''))			
			i+=1

			if (i < len-1 )
				self.addTag("symbol", ',')
			end
		end

		self.addTag("symbol", ";")
		self.addClosingTag("varDec")
	end

end