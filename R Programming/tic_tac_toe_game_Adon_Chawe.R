# addressed the following:
# use of for_loops in the computer_moves function, used sapply this time.
# removed global variables, and use of <<- to assign values
# created a method to validate user play move choice.

# Challenge: having issues assign the value from sapply, the code slows when
# i use assign(), but works okay if i use <<- within the computer_moves function.

win_positons <-
  list(
    c(1, 2, 3),
    c(4, 5, 6),
    c(7, 8, 9),
    c(1, 4, 7),
    c(2, 5, 8),
    c(3, 6, 9),
    c(1, 5, 9),
    c(3, 5, 7)
  )

# getting connection to stdin, for interacting with program
if (interactive()) {
  con <- stdin()
} else {
  con <- "stdin"
}

# Displays game boad
display_board <- function(state) {
  cat(" ", state[1], "|", state[2], "|", state[3], "\n")
  cat(" ---+---+---", "\n")
  cat(" ", state[4], "|", state[5], "|", state[6], "\n")
  cat(" ---+---+---", "\n")
  cat(" ", state[7], "|", state[8], "|", state[9], "\n")
}

# initial message
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

# This clear console
clear_console <- function() {
  cat("\014")
}

# This function validates selected position, whether numeric or not and is in accepted range
validate_user_input <- function(state, choice) {
  invalid_choice <- TRUE
  # pos_taken = TRUE
  if (!is.numeric(choice) && !choice %in% 1:9) {
    invalid_choice <- TRUE
  } else if (is.na(state[choice])) {
    invalid_choice <- TRUE
  } else if (state[choice] == "X" || state[choice] == "O") {
    invalid_choice <- TRUE
  } else {
    invalid_choice <- FALSE
  }

  while (invalid_choice == TRUE) {
    cat("Please select position between 1 - 9 that has not been taken: \n")
    choice <- readLines(con = con, n = 1)
    choice <- as.numeric(choice)
    if (!is.numeric(choice) && !choice %in% 1:9) {
      invalid_choice <- TRUE
    } else if (is.na(state[choice])) {
      invalid_choice <- TRUE
    } else if (state[choice] == "X" || state[choice] == "O") {
      invalid_choice <- TRUE
    } else {
      invalid_choice <- FALSE
    }
  }
  return(choice)
}
# This function clears the console and initiates the game
play <- function() {
  # display message
  clear_console()
  # display message
  message()
  # Select symbol for player
  cat("Please select avatar: O or X \n")
  avatar <- readLines(con = con, n = 1)
  avatar <- toupper(avatar)
  while (avatar != "X" && avatar != "O") {
    cat("Please select avatar: O or X \n")
    avatar <- readLines(con = con, n = 1)
    avatar <- toupper(avatar)
  }
  # Avatar X plays first
  if (avatar != "" && avatar == "X") {
    cat("Human(X) goes first", "\n")
    human_plays_first(h_avatar = "X", c_avatar = "O")
  } else if (avatar != "" && avatar == "O") {
    cat("Computer (X) goes first", "\n")
    computer_plays_first(h_avatar = "O", c_avatar = "X")
  }
}

# This function is invoked  when human selects O as their avatar,
# allowing the computer to play first
computer_plays_first <- function(h_avatar, c_avatar) {
  state <- as.character(1:9)
  while (win_status(state) == FALSE) {
    state <- computer_moves(state, h_avatar, c_avatar)
    display_board(state)
    cat("\n") # add space after board
    win_status(state)
    # check if game board has been used up and establish win or draw
    if (sum(state == h_avatar) + sum(state == c_avatar) == 9 &&
      win_status(state) == FALSE) {
      cat("Its a tie \n")
      display_board(state)
      cat("\n")
      break
    }
    # if win status is TRUE, end game
    if (win_status(state) == TRUE) {
      cat("Computer(X) wins \n")
      display_board(state)
      cat("\n")
      break
    }
    # Human input after computer move
    cat("Whats your move: \n")
    choice <- readLines(con = con, n = 1)
    choice <- as.numeric(choice)
    # validate input
    choice <- validate_user_input(state, choice)
    state[choice] <- h_avatar
    display_board(state)
    cat("\n")
    win_status(state)
    if (win_status(state) == TRUE) {
      cat("Human (O) wins\n")
      display_board(state)
      cat("\n")
      break
    }
  }
}

# This function is invoked when human selects x as their avatar,
# allowing them to play first
human_plays_first <- function(h_avatar, c_avatar) {
  state <- as.character(1:9)
  while (win_status(state) == FALSE) {
    # get human choice
    cat("Whats your move: \n")
    choice <- readLines(con = con, n = 1)
    choice <- as.numeric(choice)
    # validate input
    choice <- validate_user_input(state, choice)
    state[choice] <- h_avatar
    display_board(state)
    cat("\n")
    win_status(state)
    # check if board has been used up
    if (sum(state == h_avatar) + sum(state == c_avatar) == 9 &&
      win_status(state) == FALSE) {
      cat("Its a tie \n")
      display_board(state)
      cat("\n")
      break
    }
    # if win status is TRUE, end game
    if (win_status(state) == TRUE) {
      cat("Human(X) wins \n")
      display_board(state)
      cat("\n")
      break
    }

    # computer move
    state <- computer_moves(state, h_avatar, c_avatar)
    display_board(state)
    cat("\n") # add space after board
    win_status(state)
    if (win_status(state) == TRUE) {
      cat("Computer (O) wins \n")
      display_board(state)
      cat("\n")
      break
    }
  }
}

# This function generates the position play position for the computer,
# returns an updated state
computer_moves <- function(state, h_avatar, c_avatar) {
  # Wait for 1 second before playing
  Sys.sleep(1)
  random_position <- sample(1:9, size = 1, replace = TRUE) # generates a random number to for computer move
  sapply(1:length(win_positons), function(i) {
    if (sum(state[win_positons[[i]]] == c_avatar) == 2 &&
      sum(state[win_positons[[i]]] == h_avatar) == 0) {
      sapply(1:length(win_positons[[i]]), function(j) {
        # get value of the position, if doesnt contain the computer avatar but number
        if (state[win_positons[[i]][j]] != c_avatar) {
          random_position <<- win_positons[[i]][j]
        }
      })
    } else if (sum(state[win_positons[[i]]] == h_avatar) == 2 &&
      sum(state[win_positons[[i]]] == c_avatar) == 0) {
      sapply(1:length(win_positons[[i]]), function(k) {
        # get value of the position, if doesnt contain the human avatar but number

        if (state[win_positons[[i]][k]] != h_avatar) {
          random_position <<- win_positons[[i]][k]
        }
      })
    } else {
      # no one has claimed two positions already, pick a random position
      while (state[random_position] == c_avatar ||
        state[random_position] == h_avatar) {
        random_position <<- sample(1:9, size = 1, replace = TRUE) # generates a random number to for computer move
      }
    }
  })
  # replace position number on board with computer avatar,
  state[random_position] <- c_avatar
  # display message
  cat(
    "Computer(",
    c_avatar,
    ") move is: ",
    random_position,
    "\n"
  )
  return(state)
}

# This function evaluates the state, to establish if one of the player has won
win_status <- function(state) {
  win <- FALSE
  for (i in 1:length(win_positons)) {
    # check if all three position in a triple contain same avatar
    if (sum(state[win_positons[[i]]] == "X") == 3) {
      win <- TRUE
    }
    if (sum(state[win_positons[[i]]] == "O") == 3) {
      win <- TRUE
    }
  }
  return(win)
}
# initiate game
play()
