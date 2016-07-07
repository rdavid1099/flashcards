require 'minitest/autorun'
require 'minitest/pride'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/cards'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/guess'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/deck'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/round'

class FlashcardsCardsTest < Minitest::Test
  def test_cards_exist
    skip
    cards = Card.new
    assert cards
  end
  def test_questions_can_be_put_in_cards
    skip
    cards = Card.new("What is the capital of Alaska?")
    assert_equal "What is the capital of Alaska?", cards.question
  end
  def test_questions_and_answers_can_be_put_in_cards
    skip
    cards = Card.new("What is the capital of Alaska?", "Juneau")
    assert_equal "What is the capital of Alaska?", cards.question
    assert_equal "Juneau", cards.answer
  end
  def test_card_has_questions_answers_and_hints
    cards = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    assert_equal "What is the capital of Colorado?", cards.question
    assert_equal "Denver", cards.answer
    assert_equal "It's the Mile High City.", cards.hint
  end
  def test_creating_deck_from_text_file
    filename = 'cards.txt'
    cards = CardGenerator.new(filename)
    deck = Deck.new(cards.cards)
    assert_equal "What is 5 + 5?", deck.cards[0].question
    assert_equal "10", deck.cards[0].answer
    assert_equal "You should know this.", deck.cards[0].hint
    assert_equal 4, deck.count
  end
=begin
THE TESTS COMMENTED OUT BELOW READ AND WRITE FILES!!  BE SURE TO DELETE THE TEST FILES IF YOU RUN THESE!!!
  def test_saving_deck_to_text_file
    local_card_collection = "What is the capital of Colorado?;Denver;The mile high city.\nWhat is the best football team in the nation?;Denver Broncos;Super Bowl 50 champs.\n"
    filename = "test cards.txt"
    deck_creation = CreateNewDeckFile.new(local_card_collection)
    refute deck_creation.filename_exist?(filename), "Somehow we found a file called #{filename}"
    deck_creation.save_file
    assert deck_creation.filename_exist?(filename), "The file did not save!"
    assert_equal "What is the capital of Colorado?;Denver;The mile high city.\nWhat is the best football team in the nation?;Denver Broncos;Super Bowl 50 champs.\n", File.read(filename)
  end
=end
end
