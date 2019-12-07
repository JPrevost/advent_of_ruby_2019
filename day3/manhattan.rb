class Manhattan
  def dist(w1, w2)
    w1_points = navigate([0,0], w1)
    w2_points = navigate([0,0], w2)
    intersections = w1_points & w2_points
    # puts w1_points.inspect
    # puts w2_points.inspect
    # puts intersections.inspect

    min_dist(intersections)
  end

  def hops(w1, w2)
    w1_points = navigate([0,0], w1)
    w2_points = navigate([0,0], w2)
    intersections = w1_points & w2_points

    min_hops(intersections, w1_points, w2_points)
  end

  def min_hops(intersections, w1_points, w2_points)
    hops = []
    intersections.drop(1).each do |i|
      hops.append(w1_points.index(i) + w2_points.index(i))
    end
    hops.min
  end

  def min_dist(intersections)
    dists = []
    intersections.drop(1).each do |i|
      dists.append(
        (0 - i[0]).abs + (0 - i[1]).abs
      )
    end
    
    dists.min
  end

  def navigate(start, moves)
    points = [start]
    current = start

    moves.each do |move|
      dir = move[0]
      dist = move[1..].to_i

      if dir == "R"
        # add to x value
        for i in 1..dist do
          points.append([current[0] + 1, current[1]])
          current = points.last
        end
      end

      if dir == "L"
        # subtract from x value
        for i in 1..dist do
          points.append([current[0] - 1, current[1]])
          current = points.last
        end
      end

      if dir == "U"
        # add to y value
        for i in 1..dist do
          points.append([current[0], current[1] + 1])
          current = points.last
        end
      end

      if dir == "D"
        # subtract from y value
        for i in 1..dist do
          points.append([current[0], current[1] - 1])
          current = points.last
        end
      end
      current = points.last
    end
    points
  end
end
  