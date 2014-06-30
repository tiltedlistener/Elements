require_relative '../assembler/staticcounter'

class Parser

	attr_accessor :commandList
	attr_accessor :argumentList
	attr_accessor :fileSize
	attr_accessor :classes
	attr_accessor :staticObjs


	def initialize(data)		
		# Set support variables
		@rawData = data
		@commandList = Array.new
		@argumentList = Array.new
		@fileSize = @rawData.length
		@classes = []
		@staticObjs = []
		@currentClass = 'NONE'
		@staticPointer = 16
	end

	def translate
		i = 0
		while i < @fileSize do 
			getCommandType(@rawData[i])
			i += 1
		end
	end

	def getCommandType(line)
		line = line.strip
		results = nil

		if testForArthimetic(line)
			result = "C_ARITHMETIC"
		elsif testForPush(line)
			result = "C_PUSH"
		elsif testForPop(line)
			result = "C_POP"
		elsif testForLabel(line)
			result = "C_LABEL"
		elsif testForGoto(line)
			result = "C_GOTO"
		elsif testForIf(line)
			result = "C_IF"
		elsif testForFn(line)
			result = "C_FUNCTION"
		elsif testForReturn(line)
			result = "C_RETURN"
		elsif testForCall(line)
			result = "C_CALL"
		end
		@commandList.push(result)
		analyzeLine(result, line)
	end		

	# Code analysis
	def analyzeLine(result, line)
			argArray = Array.new
			arg1 = arg2 = nil
		if result == "C_ARITHMETIC"
			arg1 = line
			arg2 = nil
		elsif result == "C_PUSH" || result == "C_POP"
			line = line.gsub(/push/,'')
			line = line.gsub(/pop/,'')
			arg1 = line.match(/[a-zA-Z]+/)
			arg2 = line.match(/[0-9]+/)

			testForStatic(arg1, arg2)
		elsif result == "C_LABEL"
			arg1 = line.gsub(/label/,'').strip
			arg2 = nil
		elsif result == "C_GOTO"
			arg1 = line.gsub(/goto/,'').strip
			arg2 = nil
		elsif result == "C_IF"
			arg1 = line.gsub(/if-goto/,'').strip
			arg2 = nil
		elsif result == "C_FUNCTION"
			line = line.gsub(/function /,'')
			arg1 = line.split[0].strip
			arg2 = line.split[1].strip

			addClass(arg1.split('.')[0])
		elsif result == "C_RETURN"
			arg1 = nil
			arg2 = nil
			resetClass 
		elsif result == "C_CALL"
			line = line.gsub(/call /,'')
			arg1 = line.split[0].strip
			arg2 = line.split[1].strip
		end
		argArray = [arg1, arg2]
		@argumentList.push(argArray)
	end


	# Code Tests
	def testForArthimetic(line)
		if !line.match("add").nil?   
			return true
		elsif !line.match("sub").nil?   
			return true
		elsif !line.match("neg").nil?   
			return true
		elsif !line.match("eq").nil?   
			return true
		elsif !line.match("gt").nil?   
			return true
		elsif !line.match("lt").nil?   
			return true
		elsif !line.match("and").nil?   
			return true
		elsif !line.match("or").nil?   
			return true
		elsif !line.match("not").nil?   
			return true
		end

		return false
	end

	def testForPush(line)
		if !line.match("push").nil?   
			return true		
		end
		return false
	end

	def testForPop(line)
		if !line.match("pop").nil?   
			return true		
		end
		return false
	end

	def testForLabel(line)
		if !line.match("label").nil?   
			return true		
		end
		return false
	end

	def testForGoto(line)
		if !line.match("goto").nil? && line.match("if-goto").nil? 
			return true		
		end
		return false
	end

	def testForIf(line)
		if !line.match("if-goto").nil?   
			return true		
		end
		return false
	end

	def testForFn(line)
		if !line.match("function").nil?   
			return true		
		end
		return false
	end

	def testForReturn(line)
		if !line.match("return").nil?   
			return true		
		end
		return false	
	end

	def testForCall(line)
		if !line.match("call").nil?   
			return true		
		end
		return false
	end

	# Class precompiler
	def addClass(className)
		if (!@classes.include? className)
			@classes.push(className)
			current = StaticCounter.new(className)
			@staticObjs.push(current)
		end
		@currentClass = className
	end

	def resetClass 
		@currentClass = 'NONE'
	end

	def testForStatic(line, num)
		if line[0] == "static"			
			len = @staticObjs.length
			i = 0
			while i < len
				if (@currentClass == @staticObjs[i].class)
					@staticObjs[i].updateSize(num)
					break
				end
				i+=1
			end	
		end
	end	

	def computeStaticAllocations

		i = 0
		len = @staticObjs.length

		while i < len
			cur = @staticObjs[i]
			cur.pointer = @staticPointer
			num = 1 + cur.counter.to_i
			@staticPointer += num
			i+=1
		end

	end
end