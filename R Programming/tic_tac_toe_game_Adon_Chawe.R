win_positons <-
  list(c(1, 2, 3),
       c(4, 5, 6),
       c(7, 8, 9),
       c(1, 4, 7),
       c(2, 5, 8),
       c(3, 6, 9),
       c(1, 5, 9),
       c(3, 5, 7))

state <- as.character(1:9) #game board positions
computer_avatar = "" #computer symbol
human_avatar = "" #human symbol

#getting connection to stdin, for interacting with program
if (interactive()) {
  con <- stdin()
} else {
  con <- "stdin"
}

#Displays game boad
display_board <- function(state) {
  cat(" ", state[1], "|", state[2], "|", state[3], "\n")
  cat(" ---+---+---", "\n")
  cat(" ", state[4], "|", state[5], "|", state[6], "\n")
  cat(" ---+---+---", "\n")
  cat(" ", state[7], "|", state[8], "|", state[9], "\n")
}

#initial message
message <- function() {
  cat("=====================================\n")
  cat("|", "   Welcome to the tic_tac_game   ", "|\n")
  cat("|", "                                 ", "|\n")
  cat("|", "   Game Instructions:            ", "|\n")
  cat("|", "   1. Player with X, plays first ", "|\n")
  cat("|", "   2. Win by placing avatar in a ", "|\n")
  cat("|", "      straight or diagnal line   ", "|\n")
  cat("=====================================\n")
  cat("\n")
  cat("\n")
}

#This clear console
clear_console <- function() {
  cat("\014")
}

#This function validates selected position, whether numeric or not
validate_choice <- function(choice) {
  valid = FALSE
  if (is.numeric(choice) && choice %in% 1:9) {
    valid = TRUE
  }
  return(valid)
}

#check if position is position taken
is_position_taken <- function(choice) {
  valid = FALSE
  if (state[choice] == "X") {
    valid = TRUE
    cat("reached")
  }
  if (state[choice] == "O") {
    valid = TRUE
    cat("reached")
  }
  return(valid)
}
#This function clears the console and initiates the game
play <- function() {
  #display message
  clear_console()
  #display message
  message()
  #Select symbol for player
  cat("Please select avatar: O or X \n")
  avatar <<- readLines(con = con, n = 1)
  avatar <<- toupper(avatar)
  while (avatar != "X" && avatar != "O") {
    cat("Please select avatar: O or X \n")
    avatar <<- readLines(con = con, n = 1)
    avatar <<- toupper(avatar)
  }
  if (avatar != '' && avatar == "X") {
    human_avatar <<- avatar
    computer_avatar <<- "O"
  } else if (avatar != '' && avatar == "O") {
    human_avatar <<- avatar
    computer_avatar <<- "X"
  }
  #Player with X starts first
  if (human_avatar == "X") {
    cat("Human(X) goes first", "\n")
    display_board(state)
    cat("\n")#add space after board
    human_plays_first()
  } else{
    cat("Computer (X) goes first", "\n")
    display_board(state)
    cat("\n")#add space after board
    computer_plays_first()
  }
}

#This function is invoked  when human selects O as their avatar,
#allowing the computer to play first
computer_plays_first <- function() {
  while (win_status(state) == FALSE) {
    state <<- computer_moves(state)
    display_board(state)
    cat("\n")#add space after board
    win_status(state)
    #check if game board has been used up and establish win or draw
    if (sum(state == human_avatar) + sum(state == computer_avatar) == 9 &&
        win_status(state) == FALSE) {
      cat("Its a tie \n")
      display_board(state)
      cat("\n")#add space after board
      #reset state
      state <<- as.character(1:9)
      break
    }
    #if win status is TRUE, end game
    if (win_status(state) == TRUE) {
      cat("Computer(X) wins \n")
      display_board(state)
      cat("\n")#add space after board
      #reset state
      state <<- as.character(1:9)
      break
    }
    #Human input after computer move
    cat("Whats your move: \n")
    choice <<- readLines(con = con, n = 1)
    choice <<- as.numeric(choice)
    #validate input
    while (validate_choice(choice) == FALSE) {
      cat("Please select position between 1 - 9 that has not been taken: \n")
      choice <<- readLines(con = con, n = 1)
      choice <<- as.numeric(choice)
    }
    #check if position has already been taken
    while (is_position_taken(choice) == TRUE) {
      cat("The position has already been take, please choose another one: \n")
      choice <<- readLines(con = con, n = 1)
      choice <<- as.numeric(choice)
    }
    state[choice] <<- human_avatar
    display_board(state)
    cat("\n")#add space after board
    win_status(state)
    if (win_status(state) == TRUE) {
      cat("Human (O) wins\n")
      display_board(state)
      cat("\n")#add space after board
      #reset state
      state <<- as.character(1:9)
      break
    }
    
  }
}

#This function is invoked when human selects x as their avatar,
#allowing them to play first
human_plays_first <- function() {
  while (win_status(state) == FALSE) {
    #get human choice
    cat("Whats your move: \n")
    choice <<- readLines(con = con, n = 1)
    choice <<- as.numeric(choice)
    #validate input
    while (validate_choice(choice) == FALSE) {
      cat("Please select position between 1 - 9 that has not been taken: \n")
      choice <<- readLines(con = con, n = 1)
      choice <<- as.numeric(choice)
    }
    #check if position has already been taken
    while (is_position_taken(choice) == TRUE) {
      cat("The position has already been take, please choose another one: \n")
      choice <<- readLines(con = con, n = 1)
      choice <<- as.numeric(choice)
    }
    state[choice] <<- human_avatar
    display_board(state)
    cat("\n")#add space after board
    win_status(state)
    #check if board has been used up
    if (sum(state == human_avatar) + sum(state == computer_avatar) == 9 &&
        win_status(state) == FALSE) {
      cat("Its a tie \n")
      display_board(state)
      cat("\n")#add space after board
      #reset state
      state <<- as.character(1:9)
      break
    }
    #if win status is TRUE, end game
    if (win_status(state) == TRUE) {
      cat("Human(X) wins \n")
      display_board(state)
      cat("\n")#add space after board
      #reset state
      state <<- as.character(1:9)
      break
    }
    
    #computer move
    state <<- computer_moves(state)
    display_board(state)
    cat("\n")#add space after board
    win_status(state)
    if (win_status(state) == TRUE) {
      cat("Computer (O) wins \n")
      display_board(state)
      cat("\n")#add space after board
      #reset state
      state <<- as.character(1:9)
      break
    }
    
  }
}

#This function generates the position play position for the computer,
#returns an updated state
computer_moves <- function(state) {
  #Wait for 3 seconds before playing
  Sys.sleep(3)
  random_position = sample(1:9, size = 1, replace = TRUE) #generates a random number to for computer move
  #loop through winning combinantion to check the chances of winning
  for (i in 1:length(win_positons)) {
    #check if computer has already claimed two position in a triple win combination, and human has non
    if (sum(state[win_positons[[i]]] == computer_avatar) == 2 &&
        sum(state[win_positons[[i]]] == human_avatar) == 0) {
      #step in a triple combination to get position of empty cell
      for (j in 1:length(win_positons[[i]])) {
        #get value of the position, if doesnt contain the computer avatar but number
        if (state[win_positons[[i]][j]] != computer_avatar) {
          random_position = win_positons[[i]][j]
        }
      }
      break
    } #if human has already claimed 2 positions in a triple, block, by getting the remaining position
    else if (sum(state[win_positons[[i]]] == human_avatar) == 2 &&
             sum(state[win_positons[[i]]] == computer_avatar) == 0) {
      for (k in 1:length(win_positons[[i]])) {
        #get value of the position, if doesnt contain the human avatar but number
        if (state[win_positons[[i]][k]] != human_avatar) {
          random_position = win_positons[[i]][k]
        }
      }
    } else{
      #no one has claimed two positions already, pick a random position
      while (state[random_position] == computer_avatar ||
             state[random_position] == human_avatar) {
        random_position = sample(1:9, size = 1, replace = TRUE) #generates a random number to for computer move
      }
    }
    
  }
  #replace position number on board with computer avatar,
  state[random_position] = computer_avatar
  #display message
  cat("Computer(",
      computer_avatar,
      ") move is: ",
      random_position,
      "\n")
  return(state)
  
}

#This function evaluates the state, to establish if one of the player has won
win_status <- function(state) {
  win = FALSE
  for (i in 1:length(win_positons)) {
    #check if all three position in a triple contain same avatar
    if (sum(state[win_positons[[i]]] == "X") == 3) {
      win = TRUE
    }
    if (sum(state[win_positons[[i]]] == "O") == 3) {
      win = TRUE
    }
  }
  return(win)
}
play()