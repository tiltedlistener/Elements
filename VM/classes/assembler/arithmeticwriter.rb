require_relative 'writer'

class ArithmeticWriter < Writer

	def initialize(list)
		@commands = ["C_ARITHMETIC"]
		@list = list		
	end

	def write(instance)
		case instance.arg1.to_s.chomp
			when "neg"
				@list.addToFile("// Negating")
				@list.lookUpOneNumber
				@list.addToFile("M=-D")					
			when "not"
				@list.addToFile("// Not")
				@list.lookUpOneNumber
				@list.addToFile("M=!D")	
			when "add"
				@list.addToFile("// ADDING")
				@list.lookUpTwoNumbers
				@list.addToFile("M=D+M")
				@list.updateSP -1
			when "sub"
				@list.addToFile("// Subtracting")
				@list.lookUpTwoNumbers
				@list.addToFile("M=M-D")		
				@list.updateSP -1		
			when "and"
				@list.addToFile("// AND")	
				@list.lookUpTwoNumbers
				@list.addToFile("M=D&M")
				@list.updateSP -1
			when "or"
				@list.addToFile("// OR")					
				@list.lookUpTwoNumbers
				@list.addToFile("M=D|M")
				@list.updateSP -1	
			when "eq"
				@list.addToFile("// EQUAL")				
				@list.lookUpTwoNumbers
				@list.addToFile("D=D-M")			

				id = @list.randomNum
				@list.addToFile("@EQUAL" + id.to_s)
				@list.addToFile("D;JEQ")		
	
				@list.updateSP -1
				@list.updateSP -1					
				@list.lookUpSP					
				@list.addToFile("M=0")
				@list.addToFile("@DONE" + id.to_s)
				@list.addToFile("0;JMP")

				@list.addToFile("(EQUAL" + id.to_s  + ")")
				@list.updateSP -1
				@list.updateSP -1	
				@list.lookUpSP								
				@list.addToFile("M=-1")
				@list.addToFile("(DONE" + id.to_s  + ")")		

				@list.updateSP 1				

			when "gt"
				@list.addToFile("// Greater Than")				
				@list.lookUpTwoNumbers
				@list.addToFile("D=M-D")			

				id = @list.randomNum
				@list.addToFile("@GT" + id.to_s)
				@list.addToFile("D;JGT")		
	
				@list.updateSP -1
				@list.updateSP -1					
				@list.lookUpSP					
				@list.addToFile("M=0")
				@list.addToFile("@DONE" + id.to_s)
				@list.addToFile("0;JMP")

				@list.addToFile("(GT" + id.to_s  + ")")
				@list.updateSP -1
				@list.updateSP -1	
				@list.lookUpSP								
				@list.addToFile("M=-1")
				@list.addToFile("(DONE" + id.to_s  + ")")		

				@list.updateSP 1	
			when "lt"
				@list.addToFile("// Less Than")				
				@list.lookUpTwoNumbers
				@list.addToFile("D=M-D")			

				id = @list.randomNum
				@list.addToFile("@LT" + id.to_s)
				@list.addToFile("D;JLT")		
	
				@list.updateSP -1
				@list.updateSP -1					
				@list.lookUpSP					
				@list.addToFile("M=0")
				@list.addToFile("@DONE" + id.to_s)
				@list.addToFile("0;JMP")

				@list.addToFile("(LT" + id.to_s  + ")")
				@list.updateSP -1
				@list.updateSP -1	
				@list.lookUpSP								
				@list.addToFile("M=-1")
				@list.addToFile("(DONE" + id.to_s  + ")")		

				@list.updateSP 1					
		end		

	end

end