require 'minitest/autorun'
require 'minitest/pride'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/cards'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/guess'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/deck'
require '/Users/RyanWorkman/turing/Module1/Projects/flashcards/lib/round'

class FlashcardsRoundTest < Minitest::Test
  def test_if_round_exists
    skip
    round = Round.new
  end
  def test_a_deck_can_be_passed_into_a_round
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    assert_equal deck, round.deck
  end
  def test_round_returns_current_guesses
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    assert_equal [], round.guesses
  end
  def test_round_returns_current_card
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    assert_equal card_1, round.current_card
  end
  def test_round_can_record_guesses
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    round.record_guess("Denver")
    assert_equal "Denver",round.guesses[0].response
    assert_equal 1,round.guesses.count
  end
  def test_round_can_return_guess_feedback
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    round.record_guess("Denver")
    assert_equal "Correct!", round.guesses.first.feedback
  end
  def test_round_tracks_the_number_of_correct_guesses
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    round.record_guess("Denver")
    assert_equal 1, round.number_correct
  end
  def test_current_card_changes_after_one_card_is_answered
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    round.record_guess("Denver")
    assert_equal card_2, round.current_card
  end
  def test_round_can_record_more_than_one_answer_and_stay_current
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    round.record_guess("Denver")
    round.record_guess("Oregon")
    assert_equal 2, round.guesses.count
    assert_equal "Incorrect.", round.guesses.last.feedback
  end
  def test_round_knows_how_many_correct_answers_were_given
    card_1 = Card.new("What is the capital of Colorado?","Denver","It's the Mile High City.")
    card_2 = Card.new("Where is the show South Park based?","Colorado","A quiet, little mountain town.")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    round.record_guess("Denver")
    round.record_guess("Oregon")
    assert_equal 1, round.number_correct
    assert_equal 50, round.percent_correct
  end
=begin !!!!!TEST BELOW SAVES FILE!!!!!!
  def test_saving_results_to_file
    card_1 = Card.new("What is the capital of Alaska?","Juneau","A famous movie shares the same name.")
    card_2 = Card.new("Approximately how many miles are in one astronomical unit?", "93,000,000", "93 Bees")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    round.record_guess("Juneau")
    round.record_guess("2")
    round.save_results
    assert File.exist?("#{Date.today.strftime('%Y-%m-%d')}-#{Time.now.hour.to_s}:#{Time.now.min.to_s}.txt")
  end
=end
  def test_reshuffling_incorrect_cards
    card_1 = Card.new("What is the capital of Alaska?","Juneau","A famous movie shares the same name.")
    card_2 = Card.new("Approximately how many miles are in one astronomical unit?", "93,000,000", "93 Bees")
    deck = Deck.new([card_1, card_2])
    round = Round.new(deck)
    round.extra_practice(true)
    round.record_guess("Denver")
    refute round.guesses[0].correct?
    assert_equal 2, round.deck.count
    assert_equal round.guesses[-1].card, round.previous_card
  end
  def test_hint_functionality
    card_1 = Card.new("What is the capital of Alaska?","Juneau","A famous movie shares the same name.")
    deck = Deck.new([card_1])
    round = Round.new(deck)
    assert_equal "A famous movie shares the same name.", round.hint_to_current_question
    assert_equal "A famous movie shares the same name.", round.current_card.hint
  end
end
