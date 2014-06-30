require_relative 'writer'

class FlowWriter < Writer

	def initialize(list)
		@commands = ["C_LABEL", "C_GOTO", "C_IF", "C_FUNCTION", "C_RETURN", "C_CALL"]
		@list = list
	end

	def write(instance)
		@list.addToFile("// FLOW")
		case instance.cmd
			when "C_LABEL"
				@list.addToFile("(" + instance.arg1.to_s + ")")
			when "C_GOTO"
				@list.addToFile("@" + instance.arg1.to_s)
				@list.addToFile("0;JMP")
			when "C_IF"
				@list.updateSP -1				
				@list.lookUpSP
				@list.addToFile("D=M")
				@list.addToFile("@" + instance.arg1.to_s)
				@list.addToFile("D;JNE")
			when "C_FUNCTION"
				@list.setCurrentFn(instance.arg1.to_s)
				@list.addToFile("(" + instance.arg1.to_s + ")")

				i=0
				while i < instance.arg2.to_i
					@list.addToFile("@0")
					@list.addToFile("D=A")
					@list.lookUpSP
					@list.addToFile("M=D")
					@list.updateSP 1
					i+=1
				end
				 
			when "C_CALL"
				@list.addToFile("// CALLING")			

				# push return-address
				returnValue = @list.lineCounter.to_i + instance.arg2.to_i + 55 # Number of static commands between
				@list.addToFile("@" + returnValue.to_s)
				@list.addToFile("D=A")
				@list.lookUpSP
				@list.addToFile("M=D")
				@list.updateSP 1

				# Push LCL
				@list.addToFile("@1")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")
				@list.updateSP 1

				# push ARG
				@list.addToFile("@2")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")
				@list.updateSP 1

				# push THIS
				@list.addToFile("@3")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")
				@list.updateSP 1

				# push THAT
				@list.addToFile("@4")
				@list.addToFile("D=M")
				@list.lookUpSP
				@list.addToFile("M=D")
				@list.updateSP 1

				# arg = sp - n - 5
				offset = instance.arg2.to_i + 5
				i = 0
				@list.addToFile("@0")
				@list.addToFile("D=M")				
				while i < offset
					@list.addToFile("D=D-1")				
					i+=1
				end
				@list.addToFile("@2")
				@list.addToFile("M=D")

				# lcl = SP
				@list.addToFile("@0")
				@list.addToFile("D=M")
				@list.addToFile("@1")
				@list.addToFile("M=D")

				# GOTO AND SET RETURN LABEL
				@list.addToFile("@" + instance.arg1.to_s)
				@list.addToFile("0;JMP")
			#	@list.addToFile("(" + instance.arg1.to_s + "RETURN)")

			when "C_RETURN"
				@list.addToFile("// RETURN")				

				# Set Frame to R13
				@list.addToFile("@1")
				@list.addToFile("D=M")
				@list.addToFile("@13")
				@list.addToFile("M=D")

				# set RETURN (FRAME - 5) to R14
				# First copy 13
				@list.addToFile("@13")
				@list.addToFile("D=M")
				@list.addToFile("@14")
				@list.addToFile("M=D")
				# Then decrement 5 times
				i=0
				max=5
				while i<max 
					@list.addToFile("M=M-1")
					i+=1
				end
				# Now look up and save the return address stored there
				@list.addToFile("A=M")
				@list.addToFile("D=M")
				@list.addToFile("@14")
				@list.addToFile("M=D")

				# *ARG = pop()
				@list.lookUpAndBackSP
				@list.addToFile("D=M")
				@list.addToFile("@2")
				@list.addToFile("A=M")
				@list.addToFile("M=D")

				# SP = ARG + 1
				@list.addToFile("@2")
				@list.addToFile("D=M+1")
				@list.addToFile("@0")
				@list.addToFile("M=D")

				# set THAT
				@list.addToFile("@13")
				@list.addToFile("M=M-1")
				@list.addToFile("D=M")
				@list.addToFile("A=D")
				@list.addToFile("D=M")
				@list.addToFile("@4")
				@list.addToFile("M=D")

				# set THIS
				@list.addToFile("@13")
				@list.addToFile("M=M-1")
				@list.addToFile("D=M")
				@list.addToFile("A=D")
				@list.addToFile("D=M")
				@list.addToFile("@3")
				@list.addToFile("M=D")

				# set ARG
				@list.addToFile("@13")
				@list.addToFile("M=M-1")
				@list.addToFile("D=M")
				@list.addToFile("A=D")
				@list.addToFile("D=M")
				@list.addToFile("@2")
				@list.addToFile("M=D")

				# set LCL
				@list.addToFile("@13")
				@list.addToFile("M=M-1")
				@list.addToFile("D=M")
				@list.addToFile("A=D")
				@list.addToFile("D=M")
				@list.addToFile("@1")
				@list.addToFile("M=D")

				# set the return
				@list.addToFile("@14")
				@list.addToFile("A=M")
				@list.addToFile("0;JMP")

				@list.resetCurrentFn
		end

	end
end