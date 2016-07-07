require 'minitest/autorun'
require 'minitest/pride'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/cards'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/deck'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/guess'

class FlashcardsDeckTest < Minitest::Test
  def test_decks_exist
    skip
    deck = Deck.new
  end
  def test_you_can_add_one_card_to_the_deck
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    deck = Deck.new([card_1])
    assert_equal [card_1], deck.cards
  end
  def test_you_can_recall_two_cards_from_deck
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    assert_equal card_1, deck.cards[0]
    assert_equal card_2, deck.cards[1]
  end
  def test_you_can_count_the_number_of_cards_in_a_deck
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    assert_equal 2, deck.cards.count
  end
end
