require './utils'

def solve1
  lines = Utils.input_read(8).map {|l| l.split("|").map { |l| l.split(" ")} }

  easy_digits = lines.sum do |l|
    l[1].sum { |c|
      if [2, 3, 4, 7].include? c.length
        1
      else
        0
      end
    }
  end

  puts easy_digits
end

solve1

def possible_values(wires, solved)
  if solved.values.include? wires
    return [solved.key(wires)]
  end

  if wires.length == 2
    return [1]
  elsif wires.length == 3
    return [7]
  elsif wires.length == 4
    return [4]
  elsif wires.length == 5
    if solved[7] && wires.count(solved[7]) == 3
      return [3]
    end
    if solved[4] && wires.count(solved[4]) == 3
      return [5]
    end
    return [2, 3, 5] - solved.keys
  elsif wires.length == 6
    if solved[4] && wires.count(solved[4]) == 4
      return [9]
    end
    if solved[7] && wires.count(solved[7]) == 3
      return [0, 9] - solved.keys
    end
    return [0, 6, 9] - solved.keys
  elsif wires.length == 7
    return [8]
  end
end

def solve_number(inputs)
  displays = inputs.map { |i| { values: possible_values(i, {}), wires: i } }

  solved = false

  while solved == false do
    solutions = displays.filter { |d| d[:values].length == 1 }.inject({}) { |accum, curr|
      accum[curr[:values][0]] = curr[:wires]; accum
    }
    displays = displays.map { |d|
      { values: possible_values(d[:wires], solutions), wires: d[:wires] }
    }
    solved = displays.all? { |d| d[:values].length == 1 }
  end
  displays
end

def solve2
  lines = Utils.input_read(8).map {|l| l.split("|").map { |l| l.split(" ")} }

  solve_number((lines[4][0].concat lines[4][1]).map {|c| c.split("").sort.join}.uniq)

  result = lines.map do |line|
    displays = solve_number((line[0].concat line[1]).map {|c| c.split("").sort.join}.uniq)
    line[1].map { |d| displays.find { |h| h[:wires] == d.split("").sort.join }[:values][0] }.join("").to_i
  end
  puts result.sum
end

solve2
