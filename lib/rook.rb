class Rook
  
  attr_accessor :pos
  attr_reader :sym, :color, :moves

  def initialize(pos, color)
    @pos = pos
    @color = color
    @sym = color == :white ? "\u265c" : "\u2656"
    @moves = []
  end

  def find_moves(pcs)
    up(pcs)
    down(pcs)
    left(pcs)
    right(pcs)
  end

  def make(move, pcs)
    legal_move = get_pos(move, pos)
    @pos = moves.include?(legal_move) ? move : pos unless pos[0].to_i > 7 || pos[0].to_i < 0 && pos[1].to_i > 7 || pos[1].to_i < 0
    p pos
    p pc_captured = pcs.find { |pc| pos == pc.pos && color != pc.color }
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

  def up(pcs)
    i = 1
    while i <= 7
      move = [0, i]
      # p "up: "+(pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}"
      return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
      @moves << move
      i += 1
    end 
  end

  def down(pcs)
    i = 1
    while i <= 7
      move = [0, -i]
      # p "down: "+(pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}"
      return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
      @moves << move
      i += 1
    end 
  end

  def left(pcs)
    i = 1
    while i <= 7
      move = [-i, 0]
      # p "left: "+(pos[0].ord + move[0]).chr+"#{move[1] + 1}"
      return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
      @moves << move
      i += 1
    end
  end

  def right(pcs)
    i = 1
    while i <= 7
      move = [i, 0]
      # p "right: "+(pos[0].ord + move[0]).chr+"#{move[1] + 1}"
      return if pcs.find {|pc| pc.pos == (pos[0].ord + move[0]).chr+"#{pos[1].to_i + move[1]}" && pc.color == color}
      @moves << move
      i += 1
    end
  end

end