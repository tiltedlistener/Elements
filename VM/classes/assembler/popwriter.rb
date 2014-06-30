require_relative 'writer'

class PopWriter < Writer

	def initialize(list)
		@commands = ["C_POP"]
		@list = list
	end

	def write(instance)
		@list.addToFile("// POPPING")

		@list.addToFile("@0")
		@list.addToFile("A=M-1")
		@list.addToFile("D=M")

		case instance.arg1.to_s
			when "local"
				generateVariablePop(1, instance.arg2[0].to_i)
			when "argument"
				generateVariablePop(2, instance.arg2[0].to_i)
			when "this"
				generateVariablePop(3, instance.arg2[0].to_i)
			when "that"
				generateVariablePop(4, instance.arg2[0].to_i)			
			when "temp"
				generateFixedPop(5, instance.arg2[0].to_i)
			when "static" 	
				pointer = @list.staticRan(instance.arg2.to_s)
				@list.addToFile("@" + pointer.to_s)
				@list.addToFile("M=D")	
				
			when "pointer"
				if (instance.arg2[0].to_i == 0)
					@list.addToFile("@3")
					@list.addToFile("M=D")
				elsif (instance.arg2[0].to_i == 1)
					@list.addToFile("@4")
					@list.addToFile("M=D")
				end				
		end
		@list.updateSP -1
	end

	def generateVariablePop(pos, arg)
		@list.addToFile("@" + pos.to_s)
		if (arg.to_i > 0)
			@list.addToFile("A=M+1")			
			i=1
			while i < arg.to_i
				@list.addToFile("A=A+1")			
				i += 1
			end
		else 
			@list.addToFile("A=M")
		end
		@list.addToFile("M=D")
	end

	def generateFixedPop(fixed, arg)
		@list.addToFile("@" + fixed.to_s)
		if (arg.to_i > 0)		
			i=0
			while i < arg.to_i
				@list.addToFile("A=A+1")			
				i += 1
			end
		end
		@list.addToFile("M=D")	
	end

end