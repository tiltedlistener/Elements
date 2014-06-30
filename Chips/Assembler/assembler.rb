require 'rubygems'
require_relative 'format'
require_relative 'equation'
require_relative 'memory'

# Get File Name and read data
file = ARGV[0]
output = ARGV[1]
File.open("#{file}", "r").each_line do |line|
  Formatter.addToRawBody(line)
end
Formatter.stripComments
Formatter.stripWhitespace
Formatter.identifySymbols

# Now that symbols are swapped out, run through the filtered assembly
rawData = Formatter.readRaw
rawData.each do |line|
  if Memory.testForMemory(line)
    resultSymbol = Formatter.testForSymbol(line)
    resultPredefined = Formatter.testForPredefined(line)
    if resultSymbol
      line = resultSymbol
    elsif resultPredefined  
      line = resultPredefined
    end
    line = Memory.convertDecimalMemoryToAddress(line)
  elsif Equation.testForEquation(line)
    line = Equation.convert_equation_to_code(line)
  elsif Equation.testForJmp(line)
    line = Equation.convert_jmpcall_to_code(line)
  end
  Formatter.addToBody(line)
end

readBody = Formatter.readBody
unless output.nil?
  File.open(output, "w") do |f|  
    f.puts(readBody)
  end
else
  puts readBody
end


