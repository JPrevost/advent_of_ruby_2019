class Intcode
  def runner(opcode, pos)
    oparr = opcode[pos].to_s.chars.map(&:to_i)
    if oparr.count > 1
      op = [oparr[-2].to_s,oparr[-1].to_s].join("").to_i
      p1 = oparr[-3]
      p2 = oparr[-4]
      p3 = oparr[-4]
    else
      op = oparr[0]
    end
    a = opcode[pos+1]
    b = opcode[pos+2]
    out = opcode[pos+3]

    if op == 1
      # puts "add"
      opcode[out] = opcode[a] + opcode[b]
    elsif op == 2
      # puts "mult"
      opcode[out] = opcode[a] * opcode[b]
    elsif op == 99
      # puts "end"
      return opcode
      exit
    else
      puts "oops"
      exit
    end

    runner(opcode, pos + 4)
  end

  def futz(memory)
    nouns = (0..99)
    verbs = (0..99)
    nouns.each do |noun|
      verbs.each do |verb|
        clean_mem = memory.dup
        # puts noun, verb
        guess(clean_mem, noun, verb)
      end
    end
  end

  def guess(memory, noun, verb)
    memory[1] = noun
    memory[2] = verb
    if runner(memory, 0)[0] == 19690720
      puts "Noun: #{noun}"
      puts "Verb: #{verb}"
      puts "Answer: #{100 * noun + verb}" 
    end
  end
end

# opcode = [1,9,10,3,2,3,11,0,99,30,40,50]
# pos = 0
# Opcode.new.runner(opcode, pos)