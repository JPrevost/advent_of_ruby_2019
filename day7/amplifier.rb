require_relative '../day5/intcode'

class Amplifier
  def initialize    
  end

  # There are five amplifiers connected in series; each one receives an input 
  # signal and produces an output signal. They are connected such that the first
  # amplifier's output leads to the second amplifier's input, the second 
  # amplifier's output leads to the third amplifier's input, and so on. 
  # The first amplifier's input value is 0, and the last amplifier's output 
  # leads to your ship's thrusters.
  def compute(opcode, phase)
    input = 0
    total_thrust = 0

    phase.each do |p|
      clean_opcode = opcode.clone
      inputs = [p, input]
      phase_setting = Intcode.new.runner(clean_opcode, 0, inputs)
      total_thrust = phase_setting[:out].last
      input = total_thrust
    end
    total_thrust
  end

  def maximizer(opcode)
    maximum = 0
    phases = [0, 1, 2, 3, 4]
    phases.permutation.to_a.each do |phase|
      thrust = compute(opcode, phase)
      maximum = thrust if thrust > maximum
    end
    maximum
  end
end