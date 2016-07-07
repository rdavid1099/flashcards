require 'minitest/autorun'
require 'minitest/pride'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/cards'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/guess'

class FlashcardsGuessTest < Minitest::Test
  def test_guess_exist
    skip
    guess = Guess.new
  end
  def test_guess_can_pass_through_response
    skip
    guess = Guess.new("Denver")
    assert_equal "Denver", guess.response
  end
  def test_guess_can_pass_through_response_and_question
    card = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    guess = Guess.new("Denver", card)
    assert_equal card, guess.card
  end
  def test_guess_response_can_be_evaluated_if_correct
    card = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    guess = Guess.new("Denver", card)
    assert guess.correct?
  end
  def test_guess_response_can_be_evaluated_if_incorrect
    card = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    guess = Guess.new("Portland", card)
    refute guess.correct?
  end
  def test_guess_feedback_if_correct
    card = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    guess = Guess.new("Denver", card)
    assert_equal "Correct!", guess.feedback
  end
  def test_guess_feedback_if_incorrect
    card = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    guess = Guess.new("Portland", card)
    assert_equal "Incorrect.", guess.feedback
  end
end
