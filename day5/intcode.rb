class Intcode
  def runner(opcode, pos=0, input="")
    oparr = opcode[pos].to_s.chars.map(&:to_i)
    if oparr.count > 1
      op = [oparr[-2].to_s,oparr[-1].to_s].join("").to_i
      p1 = oparr[-3]
      p2 = oparr[-4]
      p3 = oparr[-5]
    else
      op = oparr[0]
    end
     

    if op == 1 || op == 2
      # x = opcode[pos+1]
      # a = opcode[x]

      # x = opcode[pos+2]
      # b = opcode[x]
      if p1 && p1 == 1
        # puts "p1 1"
        a = opcode[pos+1]
      else
        x = opcode[pos+1]
        a = opcode[x]
      end

      if p2 && p2 == 1
        # puts "p2 1"
        b = opcode[pos+2]
      else
        x = opcode[pos+2]
        b = opcode[x]
      end

      out = opcode[pos+3]
    end


    if op == 1
      # puts "add"÷ 
      opcode[out] = a + b
      next_op = pos + 4
    elsif op == 2
      # puts "mult"÷ 
      opcode[out] = a * b
      next_op = pos + 4
    elsif op == 3
      if p1 && p1 == 1
        puts "handle op3 non positional"
      else
        loc = opcode[pos+1]
        opcode[loc] = input
      end
      next_op = pos + 2
      
      # puts opcode.inspect, next_op
    elsif op == 4
      # puts "pos #{pos}"
      if p1 && p1 == 1
        val = opcode[pos+1]
      else
        loc = opcode[pos+1]
        val = opcode[loc]
      end
      # puts opcode.inspect
      puts val
      next_op = pos + 2
    elsif op == 99
      # puts "end"
      return opcode
      exit
    else
      puts op
      puts opcode.inspect
      puts "oops"
      exit
    end
    runner(opcode, next_op)
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