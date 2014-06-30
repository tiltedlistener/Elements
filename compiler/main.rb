require_relative 'classes/compiler'

input = ARGV[0]
output = ARGV[1]

compiler = Compiler.new(input, output)
