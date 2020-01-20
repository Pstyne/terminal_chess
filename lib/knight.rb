class Knight
  
  attr_accessor :pos
  attr_reader :sym, :color, :moves

  def initialize(pos, color)
    @pos = pos
    @color = color
    @sym = color == :white ? "\u265e" : "\u2658"
    @moves = []
  end

  def find_moves(pcs)
    up_two_left_one(pcs)
    up_two_right_one(pcs)
    up_one_left_two(pcs)
    up_one_right_two(pcs)
    down_two_left_one(pcs)
    down_two_right_one(pcs)
    down_one_left_two(pcs)
    down_one_right_two(pcs)
  end

  def make(move, pcs)
    legal_move = get_pos(move, pos)
    @pos = moves.include?(legal_move) ? move : pos unless pos[0].to_i > 7 || pos[0].to_i < 0 && pos[1].to_i > 7 || pos[1].to_i < 0
    pc_captured = pcs.find { |pc| pos == pc.pos && color != pc.color }
    pcs.delete(pc_captured)
    @moves = []
  end

  def get_pos(pos1, pos2)
    to_file = pos1[0].ord
    to_rank = pos1[1].to_i
    from_file = pos2[0].ord
    from_rank = pos2[1].to_i
    [to_file - from_file, to_rank - from_rank]
  end

  def up_two_left_one(pcs)
    move = [-1, 2]
    return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
    @moves << move
  end

  def up_two_right_one(pcs)
    move = [1, 2]
    return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
    @moves << move
  end

  def up_one_left_two(pcs)
    move = [-2, 1]
    return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
    @moves << move
  end

  def up_one_right_two(pcs)
    move = [2, 1]
    return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
    @moves << move
  end

  def down_two_left_one(pcs)
    move = [-1, -2]
    return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
    @moves << move
  end

  def down_two_right_one(pcs)
    move = [1, -2]
    return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
    @moves << move
  end

  def down_one_left_two(pcs)
    move = [-2, -1]
    return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
    @moves << move
  end

  def down_one_right_two(pcs)
    move = [2, -1]
    return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
    @moves << move
  end

end