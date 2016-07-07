class Deck
  attr_reader :cards
  def initialize(cards)
    return false if cards.length == 0 # Stop the program if the user didn't enter any cards into the deck
    @cards = cards
  end
  def count
    @cards.length
  end
end
