#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=guess -t --tuples-only -c"

USER() {
  RAND_NUM=$(( $RANDOM % 1000 + 1 ))
  echo -e "\nEnter your username: "
  read UN

  # Check if the user exists in the database
  USER=$($PSQL "SELECT player_name, games_played, best_games FROM guess WHERE player_name = '$UN'")

  if [[ -z $USER ]]; then
    echo -e "\nWelcome, $UN! It looks like this is your first time here."
    echo -e "\nGuess the secret number between 1 and 1000:\n"
    PLAY $RAND_NUM $UN
  else
    # Extract games and best from the database result
    IFS='|' read -r PLAYER_NAME GAMES BEST <<< "$USER"
    
    # Ensure we handle any potential null values
    GAMES=${GAMES//[[:space:]]/}  # Remove spaces
    BEST=${BEST//[[:space:]]/}    # Remove spaces

    # If BEST is null or empty, set it to 0
    if [[ -z "$BEST" || "$BEST" == "NULL" ]]; then
      BEST=0
    fi

    echo -e "\nWelcome back, $UN! You have played $GAMES games, and your best game took $BEST guesses."
    echo -e "\nGuess the secret number between 1 and 1000:\n"
    PLAY $RAND_NUM $UN
  fi
}

PLAY() {
  C=0  # Initialize the guess counter before the loop starts
  while true; do
    read -p "Enter your guess: " NUMBER

    # Check if the input is an integer
    if [[ ! $NUMBER =~ ^[0-9]+$ ]]; then
      echo -e "\nThat is not an integer, guess again:"
      continue
    fi

    ((C++))  # Increment the counter after each valid guess

    # Compare the guess to the secret number
    if [[ "$NUMBER" -lt "$RAND_NUM" ]]; then
      echo -e "\nIt's higher than that, guess again:"
    elif [[ "$NUMBER" -gt "$RAND_NUM" ]]; then
      echo -e "\nIt's lower than that, guess again:"
    else      
      echo -e "\nYou guessed it in $C tries. The secret number was $RAND_NUM. Nice job!"
      INSERT $UN $C  # Insert the result into the database
      break  # Exit the loop once the user guesses the number
    fi
  done
}



INSERT() {
  # Check if the user already exists
  USER_EXIST=$($PSQL "SELECT player_name FROM guess WHERE player_name = '$UN'")

  if [[ -z $USER_EXIST ]]; then
    # If user doesn't exist, insert new user with 1 game and the current guess count as best
    INSERT_NEW=$($PSQL "INSERT INTO guess(player_name, games_played, best_games) VALUES('$UN', 1, $C)")
  else
    # Update user data if they exist
    USER_STATS=$($PSQL "SELECT games_played, best_games FROM guess WHERE player_name = '$UN'")
    IFS='|' read -r GAMES BEST <<< "$USER_STATS"

    GAMES=$((GAMES + 1))

    # If the new guess count is lower than the best, update the best
    if [[ "$C" -lt "$BEST" || "$BEST" == "0" ]]; then
      BEST=$C
    fi

    # Update the user's game stats
    UPDATE_GAME=$($PSQL "UPDATE guess SET games_played = $GAMES, best_games = $BEST WHERE player_name = '$UN'")
  fi
}

USER
