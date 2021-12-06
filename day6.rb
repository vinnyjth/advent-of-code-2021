require './utils'

def solve1
  lines = Utils.input_read(6)
  fish = lines[0].split(',').map(&:to_i)
  next_fish = fish
  80.times do |day|
    next_fish = next_fish.inject([]) do |sum, f|
      next_f = f - 1
      if next_f == -1
        next_f = 6
        sum.push(8)
      end
      sum.push(next_f)
    end
    puts day
  end
  puts next_fish.count
end

# solve1

def solve2
  lines = Utils.input_read(6)
  fish = lines[0].split(',').map(&:to_i)
  next_fish = fish
  fish_count = fish.inject(Hash.new(0)) do |sum, f|
    sum[f] += 1
    sum
  end
  # puts fish_count
  256.times do |day|
    next_set = Hash.new(0)
    fish_count.keys.map do |cycle|
      if cycle != 0
        next_set[cycle - 1] += fish_count[cycle]
      else
        next_set[6] += fish_count[cycle]
        next_set[8] = fish_count[cycle]
      end
    end
    fish_count = next_set
  end
  puts fish_count.values.sum
end

solve2
