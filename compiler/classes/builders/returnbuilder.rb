class Return_Builder < Builder

	def build

		self.addOpeningTag("returnStatement")
		self.addTag("keyword", "return")

		line = @rawCode.gsub("return", '')
		line = line.gsub(";", '').strip

puts line
		if line.length > 0
			self.addOpeningTag("expression")
			self.addOpeningTag("term")
			self.addTag("identifier", line)
			self.addClosingTag("term")
			self.addClosingTag("expression")
		end

		self.addTag("symbol", ";")
		self.addClosingTag("returnStatement")
	end

end