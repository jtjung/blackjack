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

# get player's name
puts "What is your name?" 
name = gets.chomp
puts "Hi, #{name}. I'm the dealer. You will be playing 1v1 against me today. Good luck!"

# create player hand
player_hand = []

# create dealer hand
dealer_hand = []

# create + format deck
suits = ["♦︎","♣︎","♥︎","♠︎"]
numbers = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]

deck = numbers.product(suits)
deck_formatted = deck.map { |number,suit| "#{number}#{suit}"}

# shuffle deck
shuffled_deck = deck_formatted.shuffle
puts "Shuffling deck..."
puts shuffled_deck.inspect

puts "Deck has been shuffled"

# method to draw card
def draw_card(deck)
  deck.shift
end

# method to valuate hand - need to convert face cards to a numerical value
def valuate_hand(hand)
  hand.map do |card|
    card.to_i
  end.sum
end

# deal first card to player
puts "#{name} - here is your first card."
dealt_card = draw_card(shuffled_deck)
player_hand << dealt_card
puts "Your hand: #{player_hand.inspect}"

# deal first card to dealer
puts "Here is my first card."
dealt_card = draw_card(shuffled_deck)
dealer_hand << dealt_card
puts "My hand: #{dealer_hand.inspect}"


# deal the second card to player
puts "#{name} - here is your second card."
dealt_card = draw_card(shuffled_deck)
player_hand << dealt_card
puts "Your hand: #{player_hand.inspect}"


# deal the second card to dealer
puts "Here is my second card."
dealt_card = draw_card(shuffled_deck)
dealer_hand << dealt_card
puts "My hand: #{dealer_hand.inspect}"

# get player and dealer's total value
player_total = valuate_hand(player_hand)
dealer_total = valuate_hand(dealer_hand)


# playtime - player goes first - WIP
while true
  puts "#{player_total} - Hit or Stand?"  
  player_decision = gets.chomp.strip

  if player_decision.downcase == "hit"
    dealt_card = draw_card(shuffled_deck)
    player_hand << dealt_card
    puts "Your hand: #{player_hand.inspect}"
    puts "Total is #{player_total}."
    if valuate_hand(player_hand) > 21
      puts "Busted!"
      break
    end
    break
  elsif player_decision.downcase == "stand"
    break
  else
    puts "Sorry - I didn't get that. Hit or Stand?"
  end
end
