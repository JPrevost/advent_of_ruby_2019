require_relative '../day5/intcode'

class Amplifier
  def initialize(opcode)
    @opcode = opcode
  end

  # There are five amplifiers connected in series; each one receives an input 
  # signal and produces an output signal. They are connected such that the first
  # amplifier's output leads to the second amplifier's input, the second 
  # amplifier's output leads to the third amplifier's input, and so on. 
  # The first amplifier's input value is 0, and the last amplifier's output 
  # leads to your ship's thrusters.
  def compute(phase)
    input = 0
    total_thrust = 0

    phase.each do |p|
      clean_opcode = @opcode.clone
      inputs = [p, input]
      phase_setting = Intcode.new.runner(clean_opcode, 0, inputs)
      total_thrust = phase_setting[:out].last
      input = total_thrust
    end
    total_thrust
  end

  def maximizer
    maximum = 0
    phases = [0, 1, 2, 3, 4]
    phases.permutation.to_a.each do |phase|
      thrust = compute(phase)
      maximum = thrust if thrust > maximum
    end
    maximum
  end

  def feedback_loop(phase)
    input = 0
    total_thrust = 0

    intcode = Intcode.new

    inputs = phase[0]
    a = intcode.runner(@opcode, 0, inputs)

    # inputs = [phase[1], a[:out].last]
    # b = intcode.runner(@opcode, a[:out].last, inputs)

    # inputs = phase[2]
    # c = intcode.runner(@opcode, b[:out].last, inputs)
    
    # inputs = phase[3]
    # d = intcode.runner(@opcode, c[:out].last, inputs)

    # inputs = phase[4]
    # e = intcode.runner(@opcode, d[:out].last, inputs)


    # #now loop but change it it's just inputs from the last and not the phase bit
    # out = e[:out].last
    # until out == 139629729
    #   a.runner(0, [out])
    #   out = a[:out].last

    #   b.runner(0, [out])
    #   out = b[:out].last

    #   c.runner(0, [out])
    #   out = c[:out].last

    #   d.runner(0, [out])
    #   out = d[:out].last

    #   e.runner(0, [out])
    #   out = e[:out].last
    # end
a
    [a, b, c, d, e]
  end


end