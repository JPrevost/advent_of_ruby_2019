require 'minitest/autorun'
require_relative 'passwords'

class TestPasswords < MiniTest::Unit::TestCase
  def test_pass
    #    111111 meets these criteria (double 11, never decreases).
    refute(Passwords.new.legal?(111111))
    assert(Passwords.new.legal?(112233))
    assert(Passwords.new.legal?(123455))
  end

  def test_fail_decreasing
    # 223450 does not meet these criteria (decreasing pair of digits 50).
    refute(Passwords.new.legal?(223450))
  end

  def test_fail_no_double
    # 123789 does not meet these criteria (no double).
    refute(Passwords.new.legal?(123789))
  end

  def test_double_groups
    # 112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
    assert(Passwords.new.legal?(112233))

    # 123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
    refute(Passwords.new.legal?(123444))

    # 111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).
    assert(Passwords.new.legal?(111122))
 
    assert(Passwords.new.legal?(122345))

    refute(Passwords.new.legal?(111222))

    refute(Passwords.new.legal?(122234))

    refute(Passwords.new.legal?(123334))
  end

  def test_one
    # 1837 is too high
    # 1746 is too high
    # 1590 is too high
    range = (128392..643281)
    assert_equal(1390, Passwords.new.guesser(range).count)
  end
end