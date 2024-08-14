# TO DOS
# INCLUDE FACE CARDS & ASSIGN THEM VALUES

# get player's name
puts "What is your name?" 
name = gets.chomp
puts "Hi, #{name}. I'm the dealer. You will be playing 1v1 against me today. Good luck!"

sleep(1)

# create hands & turn & total values
player_hand = []
dealer_hand = []
players_turn = true

# create + format deck
suits = ["♦︎","♣︎","♥︎","♠︎"]
numbers = [2,3,4,5,6,7,8,9,10,"J","Q","K","A"]
deck = numbers.product(suits)
deck_formatted = deck.map { |number,suit| "#{number}#{suit}"}

# shuffle deck
shuffled_deck = deck_formatted.shuffle
puts "Shuffling deck..."
puts shuffled_deck.inspect

sleep(1)

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
    value = card[0..-3] # remove the suit first

    if ["J","Q","K"].include?(value) # assign value = 10 to face cards
      10
    elsif value == "A" # assign value = 11 to aces
      11
    else # assign actual value
      value.to_i
    end
  end.sum
end

# assign player & dealer total values
player_total = valuate_hand(player_hand)
dealer_total = valuate_hand(dealer_hand)

# deal first card to player
puts "#{name} - here is your first card."
draw_card(players_turn,shuffled_deck,player_hand)
player_total = valuate_hand(player_hand)

sleep(1)

# deal first card to dealer
puts "Here is my first card."
players_turn = false
draw_card(players_turn,shuffled_deck,dealer_hand)
dealer_total = valuate_hand(dealer_hand)

sleep(1)

# deal the second card to player
puts "#{name} - here is your second card."
players_turn = true
draw_card(players_turn,shuffled_deck,player_hand)
player_total = valuate_hand(player_hand)

sleep(1)

# player gets blackjack on the second card
if player_total == 21
  puts "Blackjack! You win."
  exit
end

# deal the second card to dealer
puts "Here is my second card."
players_turn = false
draw_card(players_turn,shuffled_deck,dealer_hand)
dealer_total = valuate_hand(dealer_hand)

sleep(1)

# dealer gets blackjack on the second card
if dealer_total == 21
  puts "Blackjack on me. You lose."
  exit
end

# player's turn - hit or stand?
players_turn = true

while players_turn == true
  puts "#{player_total} - Hit or Stand?"  
  player_decision = gets.chomp.strip

  # player hits
  if player_decision.downcase == "hit"
    draw_card(players_turn,shuffled_deck,player_hand)
    player_total = valuate_hand(player_hand)

    sleep(1)
    
    # player busts
    if player_total > 21
      puts "#{player_total} - Busted. Try again."
      exit
    elsif player_total < 21
      puts "You're at #{player_total}."
    else
      puts "21 - Good hit! My turn."
      break
    end
    
  # player stands
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

  sleep(1)

  # dealer busts
  if dealer_total > 21
    puts "Dealer bust. You won!"
    exit
  end
end

# who won?
if player_total > dealer_total
  puts "You won!"
elsif player_total < dealer_total
  puts "You Lost."
else
  puts "Pushed."
end