# [DONE] On start, it asks for your name. It should store this and output it at the end of the game.
# 3. The game should inform you each turn in next what is happening
# - Shuffle the deck
# - deal the player 1 card
# - deal the dealer 1 card
# - deal the player a 2nd card
# - deal the dealer a 2nd card

# For simplicity sake, it's ok that all cards are facing up so we can see the value and the suit

# 4. Create a method where anytime I type the method in console, it will show the deck's remaining contents and order
# 5. Create a turn mechanism to know who's turn it is. After dealing hands, it is always the players turn

# scoring
# hit / stand / bust mechanisms
# turns
# dealer pushes on tie
# dealer behavior, will contionue to hit unless +16
# no need to do 5 card limit unless u really wanna
# hand winner is denoted in console prompt

# TO DOS
# INCLUDE FACE CARDS & ASSIGN THEM VALUES

# get player's name
puts "What is your name?" 
name = gets.chomp
puts "Hi, #{name}. I'm the dealer. You will be playing 1v1 against me today. Good luck!"

# create hands & turn
player_hand = []
dealer_hand = []
players_turn = true

# create + format deck
suits = ["♦︎","♣︎","♥︎","♠︎"]
numbers = [2,3,4,5,6,7,8,9,10]
deck = numbers.product(suits)
deck_formatted = deck.map { |number,suit| "#{number}#{suit}"}

# shuffle deck
shuffled_deck = deck_formatted.shuffle
puts "Shuffling deck..."
puts shuffled_deck.inspect

puts "Deck has been shuffled"

# methods to draw card
def draw_card(turn,deck,hand)
  hand << deck.shift
  if turn == true
    puts "Player Hand: #{hand.inspect}"
  else
    puts "Dealer Hand: #{hand.inspect}"
  end
end

# method to valuate hand
def valuate_hand(hand)
  hand.map do |card|
    card.to_i
  end.sum
end

# deal first card to player
puts "#{name} - here is your first card."
draw_card(players_turn,shuffled_deck,player_hand)

# deal first card to dealer
puts "Here is my first card."
players_turn = false
draw_card(players_turn,shuffled_deck,dealer_hand)

# deal the second card to player
puts "#{name} - here is your second card."
players_turn = true
draw_card(players_turn,shuffled_deck,player_hand)

# deal the second card to dealer
puts "Here is my second card."
players_turn = false
draw_card(players_turn,shuffled_deck,dealer_hand)

# get player and dealer's starting total values
player_total = valuate_hand(player_hand)
dealer_total = valuate_hand(dealer_hand)

# player's turn - hit or stand?
players_turn = true

while players_turn == true
  puts "#{player_total} - Hit or Stand?"  
  player_decision = gets.chomp.strip

  if player_decision.downcase == "hit"
    draw_card(players_turn,shuffled_deck,player_hand)
    player_total = valuate_hand(player_hand)
    puts "You're at #{player_total}."
  elsif player_decision.downcase == "stand"
    players_turn = false
  else
    puts "Sorry - I didn't get that. Hit or Stand?"
  end
end

# dealer's turn - hit until >17
players_turn = false

while dealer_total <17
  draw_card(players_turn,shuffled_deck,dealer_hand)
  dealer_total = valuate_hand(dealer_hand)
  puts "#{dealer_total}"
end

# who won?
if player_total > dealer_total
  puts "You won!"
elsif player_total < dealer_total
  puts "You Lost."
else
  puts "Pushed."
end