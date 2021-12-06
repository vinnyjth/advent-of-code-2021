require './utils'

def solve1
  input = Utils.input_read(3)

  columns = (0...input[0].strip.chars.length).map do |col|
    input.map { |l| l[col] }
  end

  

  gamma_rate = columns.map do |c|
    if c.count("1") > c.count("0")
      "1"
    else
      "0"
    end
  end

  epsilon_rate = gamma_rate.map { |c| c == "0" ? "1" : "0" }

  g = gamma_rate.join("").to_i(2)
  e = epsilon_rate.join("").to_i(2)

  puts e * g
  # end
end

solve1

def make_gamma_epsilon(input)
  columns = (0...input[0].strip.chars.length).map do |col|
    input.map { |l| l[col] }
  end

  # while input.length != 0

  gamma_rate = columns.map do |c|
    if c.count("1") > c.count("0")
      "1"
    elsif c.count("1") < c.count("0")
      "0"
    else
      "1"
    end
  end

  epsilon_rate = gamma_rate.map { |c| c == "0" ? "1" : "0" }

  return gamma_rate, epsilon_rate
end

def solve2
  input = Utils.input_read(3)

  columns = (0...input[0].strip.chars.length).map do |col|
    input.map { |l| l[col] }
  end

  puts columns.map { |c| c.join("") }
  puts "next"

  eligble_gamma = input
  eligble_epsilon = input

  gamma_rate, epsilon_rate = make_gamma_epsilon(eligble_gamma)
  while eligble_gamma.length != 1 do
    gamma_rate.length.times do |i|
      gamma_rate, _ = make_gamma_epsilon(eligble_gamma)
      eligble_gamma = eligble_gamma.filter { |ev|
        ev[i] == gamma_rate[i]
      }
      break if eligble_gamma.length == 1
    end
  end

  while eligble_epsilon.length != 1 do
    epsilon_rate.length.times do |i|
      _, epsilon_rate = make_gamma_epsilon(eligble_epsilon)
      eligble_epsilon = eligble_epsilon.filter { |ev|
        ev[i] == epsilon_rate[i]
      }
      break if eligble_epsilon.length == 1
    end
  end


  g = eligble_gamma[0].to_i(2)
  e = eligble_epsilon[0].to_i(2)

  puts e * g
  # end
end

solve2
