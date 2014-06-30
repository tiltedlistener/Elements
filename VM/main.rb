# Main Parser Method
require_relative 'classes/assembler'

input = ARGV[0]
output = ARGV[1]

assembler = Assembler.new(input, output)
assembler.createCode
assembler.writeFile

