require 'minitest/autorun'
require_relative 'amplifier'

class TestAmplifier < MiniTest::Test
  # def test_amplifer
  # end

  # Max thruster signal 43210 (from phase setting sequence 4,3,2,1,0):
  # def test_1_amplifer
  #   opcode = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
  #   phase = [4,3,2,1,0]
  #   expected = 43210
  #   op = Amplifier.new(opcode).compute(phase)
  #   assert_equal(expected, op)
  # end

  # def test_2_amplifier
  #   opcode = [3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0]
  #   phase = [0,1,2,3,4]
  #   expected = 54321
  #   op = Amplifier.new(opcode).compute(phase)
  #   assert_equal(expected, op)
  # end

  # def test_3_amplifier
  #   opcode = [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
  #     1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]
  #   phase = [1,0,4,3,2]
  #   expected = 65210
  #   op = Amplifier.new(opcode).compute(phase)
  #   assert_equal(expected, op)
  # end

  # def test_1_maximizer
  #   opcode = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
  #   expected = 43210
  #   op = Amplifier.new(opcode).maximizer
  #   assert_equal(expected, op)
  # end

  # def test_2_maximizer
  #   opcode = [3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0]
  #   expected = 54321
  #   op = Amplifier.new(opcode).maximizer
  #   assert_equal(expected, op)
  # end

  # def test_3_maximizer
  #   opcode = [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
  #     1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]
  #   expected = 65210
  #   op = Amplifier.new(opcode).maximizer
  #   assert_equal(expected, op)
  # end

  # def test_day7_puzzle1
  #   opcode = [3,8,1001,8,10,8,105,1,0,0,21,38,59,76,89,106,187,268,349,430,99999,3,9,1002,9,3,9,101,2,9,9,1002,9,4,9,4,9,99,3,9,1001,9,5,9,1002,9,5,9,1001,9,2,9,1002,9,3,9,4,9,99,3,9,1001,9,4,9,102,4,9,9,1001,9,3,9,4,9,99,3,9,101,4,9,9,1002,9,5,9,4,9,99,3,9,1002,9,3,9,101,5,9,9,1002,9,3,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,99,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,99]
  #   expected = 199988
  #   op = Amplifier.new(opcode).maximizer
  #   assert_equal(expected, op)
  # end

  def test_1_feedback_loop
    opcode = [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]
    expected = 139629729
    phase = [9,8,7,6,5]
    op = Amplifier.new(opcode).feedback_loop(phase)
    assert_equal(expected, op)
  end
end