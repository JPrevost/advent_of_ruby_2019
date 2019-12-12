class Orbits
  def initialize(filename)
    @filename = filename
    @orbits = []
  end

  def mapper
    File.open(@filename, "r") do |f|
      stuff = {}
      f.each_line do |l|
        ob1, ob2 = l.split(")")
        if stuff.has_key?(ob1)
          stuff[ob1] = stuff[ob1].append(ob2.strip)
        else
          stuff[ob1] = [ob2.strip]
        end
      end
      stuff
    end
  end

  def counter
    orbiters = mapper.flatten(100).uniq
    @orbits = []
    recursive_orbitcounter(orbiters)

    @orbits.flatten.compact.count
  end

  def recursive_orbitcounter(orbiters)
    orbiters&.each do |o|
      @orbits.append(mapper[o])
      recursive_orbitcounter(mapper[o])
    end
  end

  # remove all nodes that are not relevant to target
  def ancestors(target)
    ancestors = []
    until target == "COM"
      target = parent(target)
      ancestors.append(target)
    end
    ancestors
  end

  def parent(target)
    mapper.map {|k, v| k if v.include?(target)}.compact.first
  end

  def shared_orbits(a, b)
    a_ancestors = ancestors(a)
    b_ancestors = ancestors(b)
    a_ancestors & b_ancestors
  end

  def closest_shared_orbit(a, b)
    shared_orbits(a, b).first
  end

  def transfers_to_ancestor(target, ancestor)
    ancestors(target).index(ancestor)
  end

  def transfers_to_target(a, b)
    common = closest_shared_orbit(a, b)
    a_to_common = transfers_to_ancestor(a, common)
    b_to_common = transfers_to_ancestor(b, common)
    a_to_common + b_to_common
  end
end
