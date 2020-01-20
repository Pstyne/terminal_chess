require_relative "board"
require_relative "pawn"
require_relative "rook"
require_relative "bishop"
require_relative "knight"
require_relative "queen"
require_relative "king"

# Address algebraic notation, conditions for check/checkmate, castling, en passant

def make_pawns(arr, color)
  rank = color == :white ? 2 : 7
  8.times do |i|
    file = i + 97
    arr << Pawn.new("#{file.chr}#{rank}", color)
  end
end

def make_rest(arr, color)
  rank = color == :white ? 1 : 8
  8.times do |i|
    file = i + 97
    arr << King.new("#{file.chr}#{rank}", color) if i == 4
    arr << Queen.new("#{file.chr}#{rank}", color) if i == 3
    arr << Bishop.new("#{file.chr}#{rank}", color) if i == 2 || i == 5
    arr << Knight.new("#{file.chr}#{rank}", color) if i == 1 || i == 6
    arr << Rook.new("#{file.chr}#{rank}", color) if i == 0 || i == 7
  end
end

board = Board.new
white_pawns, black_pawns, white_rooks, black_rooks = [], [], [], []
make_pawns(white_pawns, :white)
make_pawns(black_pawns, :black)
make_rest(white_rooks, :white)
make_rest(black_rooks, :black)

pieces = []
pieces << white_pawns << black_pawns << white_rooks << black_rooks
pieces.flatten!

current_player = :white

loop do 
  system('clear')
  board.squares.each do |file|
    output = ""
    file.each do |rank|
      pieces.any? {|piece| piece.pos == rank } ? 
      output <<  "[#{pieces.find {|piece| piece.pos == rank}.sym}]" : 
      output <<  "[ ]"
    end
    puts output
  end
  puts "#{current_player}, select piece: "
  from = gets.chomp
  selected = pieces.find {|piece| piece.pos == from && piece.color == current_player}
  selected.nil? ? next : nil
  selected.find_moves(pieces) unless selected.is_a?(Pawn)
  
  puts "move to: "
  move = gets.chomp
  selected.make(move, pieces)
  selected.pos == from ? next : nil
  current_player = current_player == :white ? :black : :white
end