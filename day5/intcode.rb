class Intcode
  def initialize
    @out = []
  end

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
     
    # puts [op, p1, p2, p3].inspect

    if op == 1 || op == 2
      if p1 && p1 == 1
        a = opcode[pos+1]
      else
        x = opcode[pos+1]
        a = opcode[x]
      end

      if p2 && p2 == 1
          b = opcode[pos+2]
      else
        x = opcode[pos+2]
        b = opcode[x]
      end

      out = opcode[pos+3]
    end


    # add
    if op == 1
      opcode[out] = a + b
      pos = pos + 4
            
    # multiply
    elsif op == 2
      opcode[out] = a * b
      pos = pos + 4

    # Opcode 3 takes a single integer as input and saves it to the 
    # position given by its only parameter. For example, the 
    # instruction 3,50 would take an input value and store it at 
    # address 50.
    elsif op == 3
      if p1 && p1 == 1
        puts "handle op3 non positional"
      else
        loc = opcode[pos+1]
        opcode[loc] = input
      end
      pos = pos + 2
      
    # Opcode 4 outputs the value of its only parameter. For example, 
    # the instruction 4,50 would output the value at address 50.
    elsif op == 4
      # puts "pos #{pos}"
      if p1 && p1 == 1
        val = opcode[pos+1]
      else
        loc = opcode[pos+1]
        val = opcode[loc]
      end
      # puts opcode.inspect
      @out.append(val)
      pos = pos + 2
    
    # Opcode 5 is jump-if-true: if the first parameter is non-zero, 
    # it sets the instruction pointer to the value from the second 
    # parameter. Otherwise, it does nothing.
    elsif op == 5
      if p1 && p1 == 1 # immediate mode
        if opcode[pos + 1] != 0
          if p2 && p2 == 1
            pos = opcode[pos + 2]
          else
            pos = opcode[opcode[pos + 2]]
          end
        else
          pos = pos + 3
        end
      else
        if opcode[opcode[pos + 1]] != 0
          if p2 && p2 == 1
            pos = opcode[pos + 2]
          else
            pos = opcode[opcode[pos + 2]]
          end
        else
          pos = pos + 3
        end
      end

    # Opcode 6 is jump-if-false: if the first parameter is zero, it 
    # sets the instruction pointer to the value from the second 
    # parameter. Otherwise, it does nothing.
    elsif op == 6
      if p1 && p1 == 1 # immediate mode
        if opcode[pos + 1] == 0
          if p2 && p2 == 1
            pos = opcode[pos + 2]
          else
            pos = opcode[opcode[pos + 2]]
          end
        else
          pos = pos + 3
        end
      else
        if opcode[opcode[pos + 1]] == 0            
          if p2 && p2 == 1
            pos = opcode[pos + 2]
          else
            pos = opcode[opcode[pos + 2]]
          end
        else
          pos = pos + 3
        end
      end
  
    # Opcode 7 is less than: if the first parameter is less than the 
    # second parameter, it stores 1 in the position given by the third 
    # parameter. Otherwise, it stores 0.
    elsif op == 7
      if p1 && p1 == 1 # immediate mode
        a = opcode[pos + 1]
        b = opcode[pos + 2]

        if a < b
          opcode[pos + 3] = 1
          @out.append(1)
        else
          opcode[pos + 3] = 0
          @out.append(0)
        end
      else

        a = opcode[opcode[pos + 1]]
        b = opcode[opcode[pos + 2]]

        if a < b
          opcode[pos + 3] = 1
          @out.append(1)
        else
          opcode[pos + 3] = 0
          @out.append(0)
        end
      end
      pos = pos +4


    # Opcode 8 is equals: if the first parameter is equal to the second
    # parameter, it stores 1 in the position given by the third parameter.
    # Otherwise, it stores 0
    elsif op == 8
      if p1 && p1 == 1 # immediate mode
        a = opcode[pos + 1]
        b = opcode[pos + 2]

        if a == b
          opcode[pos + 3] = 1
          @out.append(1)
        else
          opcode[pos + 3] = 0
          @out.append(0)
        end
      else
        a = opcode[opcode[pos + 1]]
        b = opcode[opcode[pos + 2]]

        if a == b
          opcode[pos + 3] = 1
          @out.append(1)
        else
          opcode[pos + 3] = 0
          @out.append(0)
        end
      end
      pos = pos + 4


    elsif op == 99
      return {
        out: @out,
        final_opcode: opcode
      }
      exit
    else
      puts op
      puts @out
      puts opcode.inspect
      puts "oops"
      exit
    end
    runner(opcode, pos, input)
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
