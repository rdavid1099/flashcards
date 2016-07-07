require 'date'

class Round
  attr_reader :deck
  attr_reader :guesses
  def initialize(deck)
    @deck = deck
    @guesses = []
    @extra_practice = nil
    @deck.cards == nil ? terminate : start
  end
  def start
    loop do
      print "\nWould you like to start a round (Y/N)?\n> "
      start_round = gets.downcase.chomp
      if start_round == 'y'
        title_screen
        extra_practice(true) if extra_practice?
        q_and_a_round
        end_game_screen
        save_results if save_results?
        break
      elsif start_round == 'n'
        break
      end
      puts "You must enter either Y or N."
    end
    puts "Thank you for playing."
  end
  def title_screen
    puts "\nLet's Play RyCARDS!  You're playing with #{@deck.cards.count} cards.\n-------------------------------------------------\n"
  end
  def end_game_screen
    puts "\n****** Game over! ******\nYou had #{number_correct} correct guesses out of #{guesses.count} for a score of #{percent_correct}%.\n"
  end
  def terminate
    puts "It appears you don't have any cards in your deck.\nThank you for playing."
  end
  def q_and_a_round
    @deck.cards.shuffle! # Shuffle the deck before the Q & A round begins
    current_card_number = 1
    deck_size = deck.cards.count
    while deck.cards[0] != nil
      puts "\nThis is card number #{current_card_number} out of #{deck_size}.\nQuestion: #{current_card.question}"
      print "Enter your answer or enter the word 'hint' for extra help.\n> "
      user_response = gets.chomp
      if user_response.downcase == 'hint'
        puts "Question: #{current_card.question}\nHint: #{hint_to_current_question}"
        print "Your answer: "
        user_response = gets.chomp
      end
      record_guess(user_response)
      if guesses.last.correct? && extra_practice?
        current_card_number += 1
      elsif extra_practice? == false
        current_card_number += 1
      end
      puts guesses.last.feedback + "\n"
    end
  end
  def extra_practice?
    return @extra_practice if @extra_practice != nil
    puts "Before we begin..."
    loop do
      print "Would you like your incorrect answers to be shuffled back into the deck (Y/N)?\n> "
      reshuffle_cards = gets.downcase.chomp
      return @extra_practice = true if reshuffle_cards == 'y'
      return @extra_practice = false if reshuffle_cards == 'n'
      puts "You must enter either Y or N."
    end
  end
  def extra_practice(more_practice = false)
    @reshuffle_incorrect_cards = more_practice
  end
  def current_card
    return @deck.cards[0]
  end
  def previous_card
    return @guesses[-1].card
  end
  def record_guess(user_guess)
    @guesses << Guess.new(user_guess, current_card)
    if @guesses[-1].correct? == false && @reshuffle_incorrect_cards == true # User didn't get question right and wants extra practice
      @deck.cards.shuffle!
      puts "Card was reshuffled into the deck."
    elsif @guesses[-1].correct? && @reshuffle_incorrect_cards == true
      @deck.cards.delete(previous_card)
    else
      @deck.cards.shift
    end
  end
  def number_correct
    @guesses.find_all {|guess| guess.correct?}.length
  end
  def percent_correct
    ((number_correct.to_f / guesses.count) * 100).round
  end
  def save_results?
    loop do
      print "Would you like to save your results (Y/N)?\n> "
      save_outcome = gets.downcase.chomp
      return true if save_outcome == 'y'
      return false if save_outcome == 'n'
      puts "Please enter either Y or N.\n"
    end
  end
  def save_results
    results_filename = "#{Date.today.strftime('%Y-%m-%d')}-#{Time.now.hour.to_s}:#{Time.now.min.to_s}.txt"
    File.new(results_filename, 'w')
    results = "On #{Date.today.strftime('%Y-%m-%d')} at #{Time.now.hour.to_s}:#{Time.now.min.to_s} user scored #{percent_correct}%.  Below are the results.\n"
    @guesses.each do |result|
      results += "-------------------------------------------------\nQuestion: #{result.card.question}\nAnswer: #{result.card.answer}\nUser Response: #{result.response}\nEvaluation: #{result.feedback}\n"
    end
    File.open(results_filename, "w") {|file| file.puts results}
  end
  def hint_to_current_question
    return current_card.hint
  end
end
