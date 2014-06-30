require_relative 'staticcounter'

# Used to hold onto the assembly data and add to it.
class AssemblyList

	attr_accessor :data
	attr_accessor :lineCounter
	attr_accessor :currentFunction
	attr_accessor :staticObjs

	def initialize
		@data = Array.new
		@lineCounter = 0
		@counter = 0

		# We'll just assume EMPTY is a protected function name
		@currentFunction = 'EMPTY'
		@staticObjs = []
	end

	def addToFile(line)
		@data.push(line)

		if (line.match("//").nil? && (line.match(/\(/).nil? && line.match(/\)/).nil?))
			@lineCounter += 1
		end
	end

	def randomNum
		@counter += 1
		return @counter
	end

	def updateSP(val)
		addToFile("@0")

		if val == -1
			addToFile("D=M-1")
		elsif val == 1
			addToFile("D=M+1")
		end

		addToFile("M=D")
	end

	def lookUpSP 
		addToFile("@0")
		addToFile("A=M")
	end

	def lookUpAndBackSP
		lookUpSP
		addToFile("A=A-1")
	end

	def lookUpOneNumber
		lookUpAndBackSP
		addToFile("D=M")
	end

	def lookUpTwoNumbers
		lookUpAndBackSP
		addToFile("D=M")
		addToFile("A=A-1")
	end

	def setCurrentFn (fn)
		@currentFunction = fn.split('.')[0]
	end

	def resetCurrentFn
		@currentFunction = 'EMPTY'
	end	

	def staticRan(num)
		# look up the staticObj for the current function
		i = 0
		len = @staticObjs.length
		pointer = 16

		while i < len
			cur = @staticObjs[i]
			if cur.class == @currentFunction
				pointer = cur.pointer
				pointer += num.to_i
				break
			end
			i+=1
		end

		return pointer
	end



end