require 'minitest/autorun'
require_relative 'intcode'

class TestIntcode < MiniTest::Test
  def test_one
    opcode = [1,9,10,3,2,3,11,0,99,30,40,50]
    expected = [3500,9,10,70, 2,3,11,0, 99, 30,40,50]
    op = Intcode.new.runner(opcode, 0)
    assert_equal(op[:final_opcode], expected)
  end

  def test_two
    opcode = [1,0,0,0,99]
    expected = [2,0,0,0,99]
    op = Intcode.new.runner(opcode, 0)
    assert_equal(op[:final_opcode], expected)
  end

  def test_three
    opcode = [2,3,0,3,99]
    expected = [2,3,0,6,99]
    op = Intcode.new.runner(opcode, 0)
    assert_equal(op[:final_opcode], expected)
  end

  def test_four
    opcode = [2,4,4,5,99,0]
    expected = [2,4,4,5,99,9801]
    op = Intcode.new.runner(opcode, 0)
    assert_equal(op[:final_opcode], expected)
  end

  def test_five
    opcode = [1,1,1,4,99,5,6,0,99]
    expected = [30,1,1,4,2,5,6,0,99]
    op = Intcode.new.runner(opcode, 0)
    assert_equal(op[:final_opcode], expected)
  end

  def test_day_two_one
    opcode = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,13,19,1,9,19,23,1,6,23,27,2,27,9,31,2,6,31,35,1,5,35,39,1,10,39,43,1,43,13,47,1,47,9,51,1,51,9,55,1,55,9,59,2,9,59,63,2,9,63,67,1,5,67,71,2,13,71,75,1,6,75,79,1,10,79,83,2,6,83,87,1,87,5,91,1,91,9,95,1,95,10,99,2,9,99,103,1,5,103,107,1,5,107,111,2,111,10,115,1,6,115,119,2,10,119,123,1,6,123,127,1,127,5,131,2,9,131,135,1,5,135,139,1,139,10,143,1,143,2,147,1,147,5,0,99,2,0,14,0]
    expected = [639495, 0, 0, 2, 1, 1, 2, 3, 1, 3, 4, 3, 1, 5, 0, 3, 2, 1, 13, 0, 1, 9, 19, 3, 1, 6, 23, 5, 2, 27, 9, 15, 2, 6, 31, 30, 1, 5, 35, 31, 1, 10, 39, 35, 1, 43, 13, 40, 1, 47, 9, 43, 1, 51, 9, 46, 1, 55, 9, 49, 2, 9, 59, 147, 2, 9, 63, 441, 1, 5, 67, 442, 2, 13, 71, 2210, 1, 6, 75, 2212, 1, 10, 79, 2216, 2, 6, 83, 4432, 1, 87, 5, 4433, 1, 91, 9, 4436, 1, 95, 10, 4440, 2, 9, 99, 13320, 1, 5, 103, 13321, 1, 5, 107, 13322, 2, 111, 10, 53288, 1, 6, 115, 53290, 2, 10, 119, 213160, 1, 6, 123, 213162, 1, 127, 5, 213163, 2, 9, 131, 639489, 1, 5, 135, 639490, 1, 139, 10, 639494, 1, 143, 2, 639494, 1, 147, 5, 0, 99, 2, 0, 14, 0]
    op = Intcode.new.runner(opcode, 0)
    assert_equal(op[:final_opcode], expected)
  end

  def test_determine_noun_and_verb
    memory = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,13,19,1,9,19,23,1,6,23,27,2,27,9,31,2,6,31,35,1,5,35,39,1,10,39,43,1,43,13,47,1,47,9,51,1,51,9,55,1,55,9,59,2,9,59,63,2,9,63,67,1,5,67,71,2,13,71,75,1,6,75,79,1,10,79,83,2,6,83,87,1,87,5,91,1,91,9,95,1,95,10,99,2,9,99,103,1,5,103,107,1,5,107,111,2,111,10,115,1,6,115,119,2,10,119,123,1,6,123,127,1,127,5,131,2,9,131,135,1,5,135,139,1,139,10,143,1,143,2,147,1,147,5,0,99,2,0,14,0]
    Intcode.new.futz(memory)
  end

  def test_opcode_position_and_immediate
    opcode = [1002,4,3,4,33]
    expected = [1002,4,3,4,99]
    op = Intcode.new.runner(opcode, 0)
    assert_equal(op[:final_opcode], expected)
  end

  def test_opcode_three_and_four
    opcode = [3,0,4,0,99]
    expected = 1234
    op = Intcode.new.runner(opcode, 0, 1234)
    assert_equal(expected, op[:out].last)
  end

  def test_negative
    opcode = [1101,100,-1,4,0]
    expected = [1101, 100, -1, 4, 99]
    op = Intcode.new.runner(opcode, 0)
    assert_equal(op[:final_opcode], expected)
  end

  def test_diagnostic
    opcode = [3,225,1,225,6,6,1100,1,238,225,104,0,1102,83,20,225,1102,55,83,224,1001,224,-4565,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,1101,52,15,225,1102,42,92,225,1101,24,65,225,101,33,44,224,101,-125,224,224,4,224,102,8,223,223,1001,224,7,224,1,223,224,223,1001,39,75,224,101,-127,224,224,4,224,1002,223,8,223,1001,224,3,224,1,223,224,223,2,14,48,224,101,-1300,224,224,4,224,1002,223,8,223,1001,224,2,224,1,223,224,223,1002,139,79,224,101,-1896,224,224,4,224,102,8,223,223,1001,224,2,224,1,223,224,223,1102,24,92,225,1101,20,53,224,101,-73,224,224,4,224,102,8,223,223,101,5,224,224,1,223,224,223,1101,70,33,225,1101,56,33,225,1,196,170,224,1001,224,-38,224,4,224,102,8,223,223,101,4,224,224,1,224,223,223,1101,50,5,225,102,91,166,224,1001,224,-3003,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1107,677,677,224,1002,223,2,223,1006,224,329,1001,223,1,223,1107,226,677,224,102,2,223,223,1005,224,344,101,1,223,223,108,677,677,224,1002,223,2,223,1006,224,359,101,1,223,223,107,677,677,224,1002,223,2,223,1006,224,374,1001,223,1,223,1007,677,677,224,102,2,223,223,1006,224,389,101,1,223,223,108,677,226,224,102,2,223,223,1006,224,404,101,1,223,223,1108,226,677,224,102,2,223,223,1005,224,419,1001,223,1,223,7,677,226,224,102,2,223,223,1005,224,434,101,1,223,223,1008,677,677,224,102,2,223,223,1006,224,449,1001,223,1,223,1007,677,226,224,1002,223,2,223,1006,224,464,101,1,223,223,1108,677,677,224,1002,223,2,223,1005,224,479,1001,223,1,223,107,226,226,224,1002,223,2,223,1005,224,494,101,1,223,223,8,226,677,224,102,2,223,223,1006,224,509,101,1,223,223,8,677,677,224,102,2,223,223,1006,224,524,101,1,223,223,1007,226,226,224,1002,223,2,223,1006,224,539,1001,223,1,223,107,677,226,224,102,2,223,223,1006,224,554,101,1,223,223,1107,677,226,224,1002,223,2,223,1006,224,569,1001,223,1,223,1008,226,677,224,102,2,223,223,1006,224,584,1001,223,1,223,1008,226,226,224,1002,223,2,223,1005,224,599,1001,223,1,223,7,677,677,224,1002,223,2,223,1005,224,614,1001,223,1,223,1108,677,226,224,1002,223,2,223,1005,224,629,101,1,223,223,7,226,677,224,1002,223,2,223,1005,224,644,1001,223,1,223,8,677,226,224,102,2,223,223,1005,224,659,101,1,223,223,108,226,226,224,102,2,223,223,1005,224,674,101,1,223,223,4,223,99,226]
    input = 1
    expected = 12428642
    # not 3, 0
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out].last)
  end

  # 3,9,8,9,10,9,4,9,99,-1,8
  # Using position mode, consider whether the input is equal to 8;
  # output 1 (if it is) or 0 (if it is not).
  def test_example_one
    opcode = [3,9,8,9,10,9,4,9,99,-1,8]
    expected = [1, 8]
    input = 8
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])

    opcode = [3,9,8,9,10,9,4,9,99,-1,8]
    expected = [0, 100]
    input = 100
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])
  end

  # 3,3,1108,-1,8,3,4,3,99
  # Using immediate mode, consider whether the input is equal to 8;
  # output 1 (if it is) or 0 (if it is not).
  def test_example_three
    opcode = [3,3,1108,-1,8,3,4,3,99]
    expected = [1, 8]
    input = 8
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])

    opcode = [3,3,1108,-1,8,3,4,3,99]
    expected = [0, 123]
    input = 123
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])
  end

  # op7 & 8

  # 3,9,7,9,10,9,4,9,99,-1,8
  # Using position mode, consider whether the input is less than 8;
  # output 1 (if it is) or 0 (if it is not).
  def test_example_two
    opcode = [3,9,7,9,10,9,4,9,99,-1,8]
    expected = [1, 3]
    input = 3
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])

    opcode = [3,9,7,9,10,9,4,9,99,-1,8]
    expected = [0, 8]
    input = 8
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])
  end

  # 3,3,1107,-1,8,3,4,3,99
  # Using immediate mode,consider whether the input is less than 8; 
  # output 1 (if it is) or 0 (if it is not).
  def test_example_four
    opcode = [3,3,1107,-1,8,3,4,3,99]
    expected = [1, 3]
    input = 3
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])

    opcode = [3,3,1107,-1,8,3,4,3,99]
    expected = [0, 8]
    input = 8
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])
  end

  # Here are some jump tests that take an input, then output 0 if the input
  # was zero or 1 if the input was non-zero:
  # 3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9 (using position mode)
  def test_jump_position_mode
    opcode = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
    expected = [1]
    input = 3
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])

    opcode = [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9]
    expected = [0]
    input = 0
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])
  end

  # 3,3,1105,-1,9,1101,0,0,12,4,12,99,1 (using immediate mode)
  def test_jump_immediate_mode
    opcode = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
    expected = [1]
    input = 3
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])

    opcode = [3,3,1105,-1,9,1101,0,0,12,4,12,99,1]
    expected = [0]
    input = 0
    op = Intcode.new.runner(opcode, 0, input)
    assert_equal(expected, op[:out])
  end

  def test_larger_example

  end
end