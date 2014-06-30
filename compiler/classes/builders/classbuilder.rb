class Class_Builder < Builder

	def setupCurrentNode
		@formattedCode.push("<class>")
		self.addTag("keyword", "class")
		self.addTag("identifier", @className)
		self.addTag("symbol", "{")
	end

	def closeCurrentNode
		self.addTag("symbol", "}")
		@formattedCode.push("</class>")
	end

	def setName(line)
		line = line.gsub("class ", '').strip
		line = line.gsub("{", "").strip
		line = line.gsub("}", "").strip
		@className = line
	end


end