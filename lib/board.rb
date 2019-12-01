class Board
  
  attr_reader :squares
  
  def initialize

    @squares = []
    8.times do |y|
      @squares << []
      8.times do |x|
        x += 97
        @squares[y] << "#{x.chr}#{y+1}"
      end
    end
    @squares.reverse!

  end

end