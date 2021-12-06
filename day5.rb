require './utils'

def solve1
  lines = Utils.input_read(5)
  start_points = lines.map { |s| s.split(' -> ')[0].split(',') }.map { |x, y| { x: x.to_i, y: y.to_i } }
  end_points = lines.map { |s| s.split(' -> ')[1].split(',') }.map { |x, y| { x: x.to_i, y: y.to_i } }

  lines = start_points.each_with_index.map { |l,i| {start: l, end: end_points[i]} }

  max_x = (start_points + end_points).max_by { |p| p[:x] }
  max_y = (start_points + end_points).max_by { |p| p[:y] }

  hits = { x: 0, y: 0 }

  points = Hash.new(0)

  # puts max_x

  lines.each do |line|
    if line[:start][:x] == line[:end][:x]
      x = line[:start][:x]
      range = [line[:start][:y], line[:end][:y]].sort
      (range[0]..range[1]).each do |y|
        points["#{x}-#{y}"] += 1
      end
    elsif line[:start][:y] == line[:end][:y]
      y = line[:start][:y]
      range = [line[:start][:x], line[:end][:x]].sort
      (range[0]..range[1]).each do |x|
        points["#{x}-#{y}"] += 1
      end
    else
      range_x = [line[:start][:x], line[:end][:x]]
      range_y = [line[:start][:y], line[:end][:y]]
      points_x = range_x.first > range_x.last ? (range_x[1]..range_x[0]).to_a.reverse : (range_x[0]..range_x[1]).to_a
      points_y = range_y.first > range_y.last ? (range_y[1]..range_y[0]).to_a.reverse : (range_y[0]..range_y[1]).to_a
      diag_points = points_x.each_with_index.map { |x, i| [x, points_y[i]] }
      diag_points.each do |x, y|
        points["#{x}-#{y}"] += 1
      end
    end
  end
  puts points.count { |k, v| v >= 2 }

  # (0..max_x[:x]).each do |x|
  #   (0..max_y[:y]).each do |y|
  #   end
  # end
end

solve1

def solve2
  lines = Utils.input_read(5)
end

solve2
