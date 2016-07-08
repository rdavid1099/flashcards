require_relative 'create_new_deck_file'
require_relative 'cards'

class CreateNewDeck
  def initialize
    @raw_string_of_cards = String.new
    @new_deck_of_cards = Array.new
  end

  def create_deck
    user_question = get_question
    @raw_string_of_cards += user_question + ";" if user_question != '0'
    return deck_created if user_question == '0'
    user_answer = get_answer
    @raw_string_of_cards += user_answer + ";"
    user_hint = get_hint
    @raw_string_of_cards += user_hint
    @new_deck_of_cards << Card.new(user_question, user_answer, user_hint.chomp)
    create_deck
  end

  def get_question
    print "You have #{@new_deck_of_cards.length} cards in your deck.\nPlease enter a question, or 0 to quit.\n> "
    return gets.chomp
  end

  def get_answer
    print "Now enter the answer to the question.\n> "
    return gets.chomp
  end

  def get_hint
    print "Now enter a hint to help the user out.\n> "
    return gets
  end

  def save_new_deck?
    return false if @new_deck_of_cards.length == 0
    print "Would you like to save your new deck of cards?\n> "
    save_deck = gets.downcase.chomp
    return true if save_deck == 'y'
    return false if save_deck == 'n'
    puts "You must enter either Y or N."
    save_new_deck?
  end

  def save_new_deck
    new_deck = CreateNewDeckFile.new(@raw_string_of_cards)
    print "What would you like to save the file as?\n> "
    new_filename = gets.downcase.chomp
    validate_filename(new_filename)
    if new_deck.filename_exist?(new_filename)
      overwrite_file?
    else
      new_deck.save_file
    end
  end

  def overwrite_file?
    print "That file already exists.  Would you like to overwrite it (Y/N)?\n> "
    overwrite_file = gets.downcase.chomp
    if overwrite_file == 'y'
      new_deck.filename_exist?(new_filename, true)
      new_deck.save_file
    elsif overwrite_file == 'n'
      puts "Please enter a new file name."
      save_new_deck
    else
      puts "You must enter either Y or N."
      overwrite_file?
    end
  end

  def validate_filename(filename)
    name_and_extension = filename.split('.')
    return filename += ".txt" if name_and_extension.count == 1
    if name_and_extension[1] == "txt"
      filename
    else
      puts "Sorry. Only .txt files are supported at this time.\nPlease try again."
      save_new_deck
    end
  end

  def deck_created
    puts "Thank you."
    save_new_deck if save_new_deck?
    @new_deck_of_cards
  end
end
