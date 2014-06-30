require_relative 'writer'

class PushWriter < Writer

	def initialize(list)
		@commands = ["C_PUSH"]
		@list = list
	end

	def write(instance)
		@list.addToFile("// PUSHING")
		case instance.arg1.to_s
			when "constant"
				@list.addToFile("@" + instance.arg2.to_s)
				@list.addToFile("D=A")
				@list.lookUpSP
				@list.addToFile("M=D")
			when "local"
				@list.addToFile("@1")
				@list.addToFile("D=M")
				@list.addToFile("@" + instance.arg2.to_s)
				@list.addToFile("A=A+D")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")
			when "argument"
				@list.addToFile("@2")
				@list.addToFile("D=M")
				@list.addToFile("@" + instance.arg2.to_s)
				@list.addToFile("A=A+D")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")
			when "temp"
				@list.addToFile("@5")
				@list.addToFile("D=A")
				@list.addToFile("@" + instance.arg2.to_s)
				@list.addToFile("A=A+D")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")	
			when "this"
				@list.addToFile("@3")
				@list.addToFile("D=M")
				@list.addToFile("@" + instance.arg2.to_s)
				@list.addToFile("A=A+D")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")
			when "that"
				@list.addToFile("@4")
				@list.addToFile("D=M")
				@list.addToFile("@" + instance.arg2.to_s)
				@list.addToFile("A=A+D")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")		
			when "static"
				pointer = @list.staticRan(instance.arg2.to_s)
				@list.addToFile("@" + pointer.to_s)
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")	
			when "pointer"
				if (instance.arg2[0].to_i == 0)
					@list.addToFile("@3")
					@list.addToFile("D=M")
					@list.lookUpSP
					@list.addToFile("M=D")
				elsif (instance.arg2[0].to_i == 1)
					@list.addToFile("@4")
					@list.addToFile("D=M")
					@list.lookUpSP
					@list.addToFile("M=D")
				end				
		end
		@list.updateSP 1
	end

end