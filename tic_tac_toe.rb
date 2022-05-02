class Game
  @@game_board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  
  
  def display_board()
  puts "    #{@@game_board[0]}    #{@@game_board[1]}    #{@@game_board[2]}
    #{@@game_board[3]}    #{@@game_board[4]}    #{@@game_board[5]}
    #{@@game_board[6]}    #{@@game_board[7]}    #{@@game_board[8]}"
  end

  def update_board_player_one(index)
    @@game_board[index] = "X"
  end

  def update_board_player_two(index)
    @@game_board[index] = "◯"
  end

  def victory_check?
    if @@game_board[0]==@@game_board[1] && @@game_board[1] == @@game_board[2]
      true
    elsif  @@game_board[3]==@@game_board[4] && @@game_board[4] == @@game_board[5]
      true
    elsif  @@game_board[6]==@@game_board[7] && @@game_board[7] == @@game_board[8]
      true
    elsif  @@game_board[0]==@@game_board[3] && @@game_board[3] == @@game_board[6]
      true
    elsif  @@game_board[1]==@@game_board[4] && @@game_board[4] == @@game_board[7]
      true
    elsif  @@game_board[2]==@@game_board[5] && @@game_board[5] == @@game_board[8]
      true
    elsif  @@game_board[0]==@@game_board[4] && @@game_board[4] == @@game_board[8]
      true
    elsif  @@game_board[2]==@@game_board[4] && @@game_board[4] == @@game_board[6]
      true
    else
      false
    end
  end

  def selection_check?(player_selection)
    if @@game_board[player_selection.to_i] == "◯" || @@game_board[player_selection.to_i] == "X"|| @@game_board[player_selection.to_i] == nil|| player_selection.match(/\D/)
      false
    else
      true
    end 
  end
end

new = Game.new
new.display_board
turn = 1
loop do
  puts "Turn no.#{turn}"
  puts "Player One, choose a cell"
  while true do  
    player_selection = gets.chomp
    if new.selection_check?(player_selection)
      break
    else
      puts "Invalid Selection! Try again!"
    end
  end
  new.update_board_player_one(player_selection.to_i)
  new.display_board
  if new.victory_check?
    puts "Player One has won the game"
    break
  end
  turn += 1
  if turn == 9
    puts "It's a tie!"
    break
  end
  puts "Turn no.#{turn}"
  puts "Player Two, choose a cell"
  while true do  
    player_selection = gets.chomp
    if new.selection_check?(player_selection)
      break
    else
      puts "Invalid Selection! Try again!"
    end
  end
  new.update_board_player_two(player_selection.to_i)
  new.display_board
  turn += 1
  if new.victory_check?
    puts "Player Two has won the game"
    break
  end
end
