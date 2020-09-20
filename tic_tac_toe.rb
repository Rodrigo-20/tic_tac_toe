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
     case position[0]
     when "A" then row = 0
     when "B" then row = 1
     when "C" then row = 2
     else row = "incorrect position, try again" 
     end
      
    case position[1]
    when "1" then column = 0 
    when "2" then column = 1 
    when "3" then column = 2
    else column = "incorrect position, try again" 
    end
   
    if ! self.boxes_filled.include?(position) and column.is_a?(Integer) and row.is_a?(Integer)      
      self.board_boxes[row][column]=player.mark
      self.boxes_filled << position
      player.boxes_filled << position
      position
      #puts self.board_boxes.join("-")
      #puts self.boxes_filled
    else
       "Incorrec selection, Try again "
      #return "my bad"
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

  def player_turn(player)
    result=0
    loop do
      puts "#{player.name} make your move :"
      pos=gets.chomp
      result = self.board.position_handler(player,pos)
      self.board.display_board
      break if result.length == 2
    end
  end

  def win(player)
    player_moves=player.boxes_filled.join
    lines=["A","B","C","1","2","3"]
    cross_1=["A1","B2","C3"]
    cross_2=["A3","B2","C1"]
    cond1= self.sub_strings(player_moves,lines).values.any? {|number| number>=3}
    cond2= self.sub_strings(player_moves,cross_1).values.reduce {|total,number| total + number}
    cond3= self.sub_strings(player_moves,cross_2).values.reduce {|total,number| total + number}
    if cond1 or cond2==3 or cond3==3
      return true
    end  

  end
  
  def play
    someone_win=false
    self.add_player
    self.add_player
    self.players[0].mark="X"
    self.players[1].mark="O"
    loop do
    self.player_turn(players[0])
    break if win(players[0]) or self.board.boxes_filled.length== 9
    self.player_turn(players[1])  
    break if win(players[1]) or self.board.boxes_filled.length== 9
    end
    if win(players[0]) 
      puts "#{players[0].name} wins !"
    elsif win(players[1])
      puts "#{players[1].name} wins !"
    else 
      puts "Shame, Its a Tie " 
    end    
  end
end 
juego=Game.new()
juego.play
