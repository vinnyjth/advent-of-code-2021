require './utils'


def score_board(num, boards)
  boards = boards.map do |board|
    board.map do |row|
      row.map do |col|
        col == num ? "x-#{col}" : col
      end
    end
  end

  winner = boards.find do |board|
    horizontal = board.any? do |row|
      row.all? { |col| col.start_with? 'x' }
    end

    vertical = board[0].each_with_index.any? do |col, i|
      board.map { |r| r[i] }.all? { |col| col.start_with? 'x' }
    end

    vertical || horizontal
  end


  return boards, winner
end

def solve1
  lines = Utils.input_read(4)
  number_pool = lines[0].split(",")


  boards = []
  current_board = []
  lines[2..-1].each do |l|
    if l.strip == ""
      boards.push(current_board)
      current_board = []
    else
      current_board.push(l.split " ")
    end
  end
  boards.push(current_board)

  i = 0
  winning_board = nil
  while winning_board == nil
    num = number_pool[i]

    boards, winning_board = score_board(num, boards)


    i += 1
  end

  unmarked_sum = winning_board.flatten.reject { |c| c.start_with? "x" }.map(&:to_i).sum
  puts number_pool[i-1].to_i
  puts unmarked_sum * number_pool[i-1].to_i
end

solve1

def score_board2(num, boards)
  boards = boards.map do |board|
    board.map do |row|
      row.map do |col|
        col == num ? "x-#{col}" : col
      end
    end
  end

  winners = boards.filter do |board|
    horizontal = board.any? do |row|
      row.all? { |col| col.start_with? 'x' }
    end

    vertical = board[0].each_with_index.any? do |col, i|
      board.map { |r| r[i] }.all? { |col| col.start_with? 'x' }
    end

    vertical || horizontal
  end


  return boards, winners
end

def solve2
  lines = Utils.input_read(4)
  number_pool = lines[0].split(",")


  boards = []
  current_board = []
  lines[2..-1].each do |l|
    if l.strip == ""
      boards.push(current_board)
      current_board = []
    else
      current_board.push(l.split " ")
    end
  end
  boards.push(current_board)

  i = 0
  winning_boards = []
  while winning_boards.length != boards.length - 1
    num = number_pool[i]

    boards, winning_boards = score_board2(num, boards)

    i += 1
  end

  last_board = boards.reject { |b| winning_boards.map {|r| r[0] }.include? b[0] }[0]

  while winning_boards.length != boards.length
    num = number_pool[i]

    boards, winning_boards = score_board2(num, boards)

    i += 1
  end

  final_board = winning_boards.find { |b|
    b[0].map { |c| c.split("-")[-1] } == last_board[0].map { |c| c.split("-")[-1] }
  }

  # puts final_board

  unmarked_sum = final_board.flatten.reject { |c| c.start_with? "x" }.map(&:to_i).sum
  puts number_pool[i-1].to_i
  puts unmarked_sum * number_pool[i-1].to_i
end

solve2
