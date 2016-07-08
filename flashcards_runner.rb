require './lib/create_new_deck'
require './lib/upload_saved_deck'
require './lib/deck'
require './lib/round'

puts "Welcome To RyCards... Where flashcards are our business."
user_deck = String.new
until user_deck == 'y' || user_deck == 'n'
  print "First, do you have a previous deck saved (Y/N)? \n> "
  user_deck = gets.downcase.chomp
  puts "\nYou must enter either Y or N.\n" if user_deck != 'y' && user_deck != 'n'
end
if user_deck == 'y'
  local_cards = UploadSavedDeck.new.read_file
else
  local_cards = CreateNewDeck.new.create_deck
end
puts "\nThank you.  We are now creating and shuffling your deck of #{local_cards.length} cards." if local_cards.length > 0
deck = Deck.new(local_cards)
round = Round.new(deck)
