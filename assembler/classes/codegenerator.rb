require_relative 'parse/parser'
require_relative 'parse/lineinstance'
require_relative 'assembler/assemblylist'
require_relative 'assembler/arithmeticwriter'
require_relative 'assembler/pushwriter'
require_relative 'assembler/popwriter'
require_relative 'assembler/flowwriter'
require_relative 'init/basic'
require_relative 'init/fntestinit'


class CodeGenerator

	def initialize
		@assemblyList = AssemblyList.new
		# init = BasicInit.new(@assemblyList)
		init = FnTestInit.new(@assemblyList)
	end

	# Basic Getter/Setter methods
	def setData(data)
		@data = data
	end

	def getData 
		return @final
	end

	def translate
		@parser = Parser.new(@data)
		@parser.translate
		@parser.computeStaticAllocations

		# Bit hacky, but Assembly List is within the context of the writers
		@assemblyList.staticObjs = @parser.staticObjs
	end

	def createAssembly
		flow = FlowWriter.new(@assemblyList)
		push = PushWriter.new(@assemblyList)
		pop = PopWriter.new(@assemblyList)
		arth = ArithmeticWriter.new(@assemblyList)

		i = 0
		while i < @parser.fileSize do 
			cmd = @parser.commandList[i]
			arg1 = @parser.argumentList[i][0]
			arg2 = @parser.argumentList[i][1]
			instance = LineInstance.new(cmd, arg1, arg2)

			if flow.commands.include? instance.cmd
				puts "FLOW"
				flow.write(instance)
			elsif push.commands.include? instance.cmd
				puts "PUSH"
				push.write(instance)
			elsif pop.commands.include? instance.cmd
				puts "POP"
				pop.write(instance)
			elsif arth.commands.include? instance.cmd
				puts "ARTH"
				arth.write(instance)
			else
				puts "ERROR: Command does not exists"
				break 
			end
					
			i += 1
		end
		@final = @assemblyList.data
	end

end