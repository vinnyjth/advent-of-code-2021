require './utils'


def solve1
  lines = Utils.input_read(1)
  last_line = nil
  increases = 0
  lines.each do |current_line|
    current_line = current_line.to_i
    if last_line && last_line < current_line
      increases += 1
    end

    last_line = current_line
  end

  puts increases
end

solve1

def solve2
  lines = Utils.input_read(1).map(&:to_i)
  last_line = nil
  increases = 0
  lines.each_with_index do |current_line, i|
    if i > 2
      current_window = lines[(i - 2)..(i)].sum
      last_window = lines[(i - 3)..(i-1)].sum
      increases += 1 if current_window > last_window
    end
  end

  puts increases
end

solve2