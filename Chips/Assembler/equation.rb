
module Equation

  def self.testForEquation(line)
    test = line.match("=")

    if test.nil?
      return false
    else
      return true
    end

  end

  def self.testForJmp(line)
    test = line.match(';J')

    if test.nil?
      return false
    else
      return true
    end
  end

  def self.convert_jmpcall_to_code(line)
    res = '111'
    dest = '000'
    jmp = self.convert_to_jmp(line)
    equation = self.convert_jmp_res_to_code(line)
    coded_equation = self.convert_equation_to_command(equation)

    res = res + coded_equation + dest + jmp
    return res
  end

  def self.convert_jmp_res_to_code(line)
    line = line.gsub(/;J(.*)/, '')
    return line
  end

  def self.convert_to_jmp(line)
    if !line.match("JGT").nil?   
      cmd = "001"
    elsif (!line.match("JEQ").nil?)
      cmd = "010"
    elsif (!line.match("JGE").nil?) 
      cmd = "011"
    elsif (!line.match("JLT").nil?) 
      cmd = "100"
    elsif (!line.match("JNE").nil?) 
      cmd = "101"
    elsif (!line.match("JLE").nil?) 
      cmd = "110"
    elsif (!line.match("JMP").nil?)
      cmd = "111"
    end         

    return cmd
  end

  def self.convert_equation_to_code(line)
    res = '111'

    equation = self.filter_equals_to_equation(line)
    coded_equation = self.convert_equation_to_command(equation)
    
    dest = self.convert_to_dest(line)
    jmp = '000'

    res = res + coded_equation + dest + jmp
    return res
  end

  def self.filter_equals_to_equation(line)
    equation = line.match("=(.*)")

    formattedEquation = equation[0]
    formattedEquation[0] = ''

    return formattedEquation
  end


  def self.convert_to_dest(line)
    # DESTINATION #
    destMatch = line.match("(.*)=")[0]
    
    # Dest is ADM
    unless destMatch.match("A").nil?
      cmd = "1"
    else
      cmd = "0"
    end

    unless destMatch.match("D").nil?
      cmd << "1"
    else
      cmd << "0"
    end

    unless destMatch.match("M").nil?
      cmd << "1"
    else
      cmd << "0"
    end   

    return cmd  
  end


  def self.convert_equation_to_command(equation)
    equation = equation.strip

    mPresent = equation.match("M")
    if mPresent.nil?
      cmd = "0"
    else 
      cmd = "1"
    end

    if equation == "0"
      cmd << "101010"
    elsif equation == "1"
      cmd << "111111"
    elsif equation == "-1"
      cmd << "111010"
    elsif equation == "D"
      cmd << "001100"
    elsif equation == "A" || equation == "M"
      cmd << "110000"
    elsif equation == "!D"
      cmd << "001101"
    elsif equation == "!A" || equation == "!M"
      cmd << "110001"
    elsif equation == "-D"
      cmd << "001111"
    elsif equation == "-A" || equation == "-M"
      cmd << "110011"
    elsif equation == "D+1"
      cmd << "011111"
    elsif equation == "A+1" || equation == "M+1" 
      cmd << "110111"
    elsif equation == "D-1"
      cmd << "001110"
    elsif equation == "A-1" || equation == "M-1"
      cmd << "110010"
    elsif equation == "D+A" || equation == "D+M" 
      cmd << "000010"
    elsif equation == "D-A" || equation == "D-M" 
      cmd << "010011"
    elsif equation == "A-D" || equation == "M-D" 
      cmd << "000111"
    elsif equation == "D&M" || equation == "D&A"
      cmd << "000000"
    elsif equation == "D|A" || equation == "D|M"
      cmd << "010101"
    end
    return cmd
  end

end

