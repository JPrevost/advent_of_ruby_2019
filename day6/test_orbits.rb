# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'orbits'

class TestObits < MiniTest::Unit::TestCase
  def test_map
    assert_equal(["B"], Orbits.new("example.txt").mapper["COM"])
    assert_equal(["C", "G"], Orbits.new("example.txt").mapper["B"])
    assert_equal(["D"], Orbits.new("example.txt").mapper["C"])
    assert_equal(["E", "I"], Orbits.new("example.txt").mapper["D"])
    assert_equal(["F", "J"], Orbits.new("example.txt").mapper["E"])
    assert_equal(["H"], Orbits.new("example.txt").mapper["G"])
    assert_equal(["K"], Orbits.new("example.txt").mapper["J"])
    assert_equal(["L"], Orbits.new("example.txt").mapper["K"])
  end

  def test_counter
    assert_equal(42, Orbits.new("example.txt").counter)
  end

  def test_puzzle
    # this takes 5 minutes so probs only run if you need to
    # assert_equal(139597, Orbits.new("puzzle.txt").counter)
  end

  def test_ancestors
    assert_equal(["K", "J", "E", "D", "C", "B", "COM"],
                 Orbits.new("example_2.txt").ancestors('YOU'))
    assert_equal(["I", "D", "C", "B", "COM"],
                 Orbits.new("example_2.txt").ancestors('SAN'))
  end

  def test_shared_orbits
    assert_equal(["D", "C", "B", "COM"], Orbits.new("example_2.txt").shared_orbits('YOU', 'SAN'))
  end

  def test_closest_shared_orbit
    assert_equal('D', Orbits.new("example_2.txt").closest_shared_orbit('YOU', 'SAN'))
  end

  def test_transfers_to_ancestor
    assert_equal(3, Orbits.new("example_2.txt").transfers_to_ancestor('YOU', 'D'))
    assert_equal(1, Orbits.new("example_2.txt").transfers_to_ancestor('SAN', 'D'))
  end 

  def test_transfers_to_target
    assert_equal(4, Orbits.new("example_2.txt").transfers_to_target('YOU', 'SAN'))
  end

  def test_puzzle_part_two
    assert_equal(286, Orbits.new("puzzle.txt").transfers_to_target('YOU', 'SAN'))
  end
end
