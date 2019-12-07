@sum = 0

# fuel required for a module, take its mass, divide by three, 
# round down, and subtract 2.

def fuel_req(mass)
  (mass.to_i / 3).floor - 2
end

def fuelinator(mass)
  sub = fuel_req(mass)
  # puts "Sub mass #{sub}"
  @sum = @sum + sub if sub > 0
  if sub > 0
    fuelinator(sub)
  end
end

File.open("fuel_requirements.txt", "r") do |f|
  f.each_line do |l|
    # puts "Input mass #{l}"
    fuelinator(l)
  end
end

puts @sum
