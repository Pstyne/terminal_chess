# TODOs: Promotion, En passant 

class Pawn
  
  attr_accessor :pos
  attr_reader :sym, :color, :moves, :moved, :attack, :en_passant, :up, :down, :white_capture, :black_capture, :move_type

  def initialize(pos, color, moved=false)
    @up = [[0,1], [0,2]]
    @down = [[0,-1], [0,-2]]
    @white_capture = [[-1,1], [1,1]]
    @black_capture = [[-1,-1], [1,-1]]
    @pos = pos
    @color = color
    @sym = color == :white ? "\u265f" : "\u2659"
    @attack = sym == "\u265f" ? white_capture : black_capture
    @moves = sym == "\u265f" ? up : down
    @move_type = sym == "\u265f" ? up : down
  end

  def make(move, pcs)
    space_occupied?(pcs, move)
    capture_move?(pcs, move)
    legal_move = get_pos(move, pos)
    @pos = moves.include?(legal_move) ? move : pos unless pos[1].to_i > 7 || pos[1].to_i < 0
    pc_captured = pcs.find { |pc| pos == pc.pos && color != pc.color }
    pcs.delete(pc_captured)
    @moves.delete(attack) unless @moved
    @moved = true
  end

  def space_occupied?(pcs, move)
    pcs.each do |pc|
      forward = get_pos(pc.pos, pos)
      moves.any? {|a| a == forward ? @moves = [] : @moves = moved ? [move_type.first] : move_type}
    end
  end

  def capture_move?(pcs, move)
    pcs.each do |pc|
      capture_move = get_pos(pc.pos, pos)
      @moves << capture_move if attack.any? {|a| a == capture_move}
    end
  end

  def get_pos(pos1, pos2)
    to_file = pos1[0].ord
    to_rank = pos1[1].to_i
    from_file = pos2[0].ord
    from_rank = pos2[1].to_i
    [to_file - from_file, to_rank - from_rank]
  end

end