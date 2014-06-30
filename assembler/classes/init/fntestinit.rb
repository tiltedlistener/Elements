class FnTestInit

	def initialize(list)
		list.addToFile("// Initializing with FnTestInit")
		list.addToFile("@256")
		list.addToFile("D=A")
		list.addToFile("@0")
		list.addToFile("M=D")

		list.addToFile("@300")
		list.addToFile("D=A")
		list.addToFile("@1")
		list.addToFile("M=D")		

		list.addToFile("@400")
		list.addToFile("D=A")
		list.addToFile("@2")
		list.addToFile("M=D")		

		list.addToFile("@3000")
		list.addToFile("D=A")
		list.addToFile("@3")
		list.addToFile("M=D")

		list.addToFile("@3010")
		list.addToFile("D=A")
		list.addToFile("@4")
		list.addToFile("M=D")		

		list.addToFile("0;JNE")
		list.addToFile("0;JNE")				
	end

end