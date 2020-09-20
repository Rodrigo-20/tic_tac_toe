module SubString
  def sub_strings(string, dictionary)
    # included=[]
    test_string = '! ' + string + ' !'
    included = dictionary.map { |word| Array.new(test_string.upcase.split(word).length - 1, word) }.reduce([]) do |words_array, some_word_repeated|
      words_array + some_word_repeated
    end
    included.each_with_object(Hash.new(0)) do |word_hits, word|
      word[word_hits] += 1
    end
    # return asd
  end
end  
class Player 
    attr_accessor :name, :mark, :board, :boxes_filled
    def initialize(name)
      @name=name
      @board
      @boxes_filled=[]
      @mark
    end
end
class Board
  attr_accessor :boxes_filled, :players, :board_boxes, :board
  def initialize  
      @boxes_filled = []
      @board_boxes=[[" "," "," "],[" "," "," "],[" "," "," "]]
      @players=[]
  end  
     
  def position_handler(player,position)
     coordinates=position.split("")
     
     case coordinates[0]
     when "A" then row = 0
     when "B" then row = 1
     when "C" then row = 2
     end
  
    case coordinates[1]
    when "1" then column = 0 
    when "2" then column = 1 
    when "3" then column = 2
    end
    box=[row,column]
    #puts box
  
    if ! self.boxes_filled.include?(position)
      
      self.board_boxes[row][column]=player.mark
      self.boxes_filled << position
      player.boxes_filled << position  
      #puts self.board_boxes.join("-")
      #puts self.boxes_filled
    else puts "Incorrec selection, Try again "
    end
  end

  def display_board 
      puts "\t\t\t1\t2\t3
      A | #{self.board_boxes[0][0]} | #{self.board_boxes[0][1]} | #{self.board_boxes[0][2]} |\n
      B | #{self.board_boxes[1][0]} | #{self.board_boxes[1][1]} | #{self.board_boxes[1][2]} |\n
      C | #{self.board_boxes[2][0]} | #{self.board_boxes[2][1]} | #{self.board_boxes[2][2]} |\n"
  end  
end  

class Game
  include SubString
  attr_accessor :players, :board
  def initialize
    @board= Board.new()
    @players=[]
  end

  def add_player
    puts "Enter the name of the player "
    player=gets.chomp
    self.players<<Player.new(player)
  end

  def win(player)
    player_moves=player.boxes_filled.join
    dictionary=["A","B","C","1","2","3"]
    puts result=self.sub_strings(player_moves,dictionary)
  end
  
  def play
    self.add_player
    self.add_player
    self.players[0].mark="X"
    self.players[1].mark="O"
    puts "#{players[0].name} Enter coordinate :"
    pos=gets.chomp
    self.board.position_handler(players[0],pos)
    self.board.display_board
    puts "Enter coordinate :"
    pos=gets.chomp
    self.board.position_handler(players[1],pos)
    self.board.display_board
    win(players[0])
  end
end 
juego=Game.new()
juego.play
