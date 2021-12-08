require './utils'

def solve1
  lines = Utils.input_read(7)
  crabs = lines[0].split(",").map(&:to_i)
  crab_range = (crabs.min..crabs.max)

  puts crab_range
  costs = crab_range.map do |h|
    fuel_cost = crabs.inject(0) { |sum, c|
      sum + (
        (0..(c - h).abs).inject(0) { |fuel_sum, cur|
          fuel_sum + cur
      })
    }
    puts h
    { pos: h, cost: fuel_cost }
  end
  puts costs.sort_by { |cc| cc[:cost] }[0]
end

solve1

def solve2
  crabs = Utils.input_read(7).split(",").map(&:to_i)[1]
  lowest_cost = (crabs.min..crabs.max).map do |h|
    fuel_cost = crabs.inject(0) do |sum, c|
      sum + ((0..(c - h).abs).inject(0) { |fuel_sum, cur|
        fuel_sum + cur
      })
    end
    { pos: h, cost: fuel_cost }
  end.sort_by { |cc| cc[:cost] }[0]
  puts lowest_cost
end

solve2
