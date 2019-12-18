class SpaceImageFormat
  def parse(data, height, width)
    image = []
    rows = data.to_s.scan(/.{1,#{width}}/)

    rows.each_slice(height) do |r|
      image.append(r)
    end
    image
  end

  # To make sure the image wasn't corrupted during transmission, the Elves would 
  # like you to find the layer that contains the fewest 0 digits. On that layer, 
  # what is the number of 1 digits multiplied by the number of 2 digits?
  def check(data, height, width)
    layers = parse(data, height, width)

    fewest = ['000000000000'] # assume we have a row with less than this many 0s
    layers.each do |l|
      if l.join('').count('0') < fewest.join('').count('0')
        fewest = l
      end
    end
    fewest_ones = fewest.join('').count('1')
    fewest_twos = fewest.join('').count('2')
    fewest_ones * fewest_twos
  end

  def flatten(data, height, width)
    layers = parse(data, height, width)
    flat = []
    
    layers[0].each_with_index do |r, ri|
      r.split('').each_with_index do |c, ci|
        flat.append(color(layers.map{|x| x[ri][ci]}))
      end
    end

    parse(flat.join(''), height, width).flatten
  end

  # take an array of pixels in order of layers and output the top most
  # non-transparent pixel color
  def color(pixel_layers)
    pixel_layers.delete('2')
    pixel_layers.first
  end

  def print(data, height, width)
    flat = flatten(data, height, width)
    puts
    flat.each do |r|
      puts r.split('').map {|x| x == "0" ? ' ' : '#'}.join('')
    end
    puts
  end
end
