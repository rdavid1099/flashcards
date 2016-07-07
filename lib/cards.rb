require 'pry'
class Card
  attr_reader :question, :answer, :hint
  def initialize(question, answer, hint)
    @question = question
    @answer = answer
    @hint = hint
  end
end

class CardGenerator
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def cards
    cards_in_file = File.read(file_name).split(/\n/)
    cards_in_file.map do |card|
      card_data = card.split(';')
      Card.new(card_data[0],card_data[1],card_data[2])
    end
  end
end

class UploadSavedDeck
  def read_file
    print "Enter the name of the deck file now, or enter a new name to create a new deck.\n> "
    filename = gets.downcase.chomp
    validate_filename(filename)
    if File.exist?(filename)
      CardGenerator.new(filename).cards if File.exist?(filename)
    else
      print "#{filename} does not yet exist. Create new deck #{filename}? (Y or N)\n> "
      response = gets.chomp.upcase
      if response == 'Y'
        CreateNewDeck.new.create_deck # Pass through filename
      else
        puts "No problem. Let's try again."
        read_file
      end
    end
  end

  def validate_filename(filename)
    name_and_extension = filename.split('.')
    binding.pry
    return filename += ".txt" if name_and_extension.count == 1
    if name_and_extension[1] == "txt"
      filename
    else
      puts "Sorry. Only .txt files are supported at this time.\nPlease try again."
      read_file
    end
  end
end

class CreateNewDeck
  def initialize
    @raw_string_of_cards = String.new  # String that can be saved to a text file if user wants to save the questions they entered
    @new_deck_of_cards = Array.new
  end
  def create_deck
    loop do
      user_question = get_question
      @raw_string_of_cards += user_question + ";" if user_question != '0' # Ensures a 0 is not tacked on to the end of the raw string of cards for the text file
      break if user_question == '0'
      user_answer = get_answer
      @raw_string_of_cards += user_answer + ";"
      user_hint = get_hint
      @raw_string_of_cards += user_hint
      @new_deck_of_cards << Card.new(user_question, user_answer, user_hint.chomp)
      @new_deck_of_cards.shuffle! # Automatically shuffle the cards to keep things interesting
    end
    puts "Thank you."
    save_new_deck if save_new_deck?
    return @new_deck_of_cards
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
    loop do
      print "Would you like to save your new deck of cards?\n> "
      save_deck = gets.downcase.chomp
      return true if save_deck == 'y'
      return false if save_deck == 'n'
      puts "You must enter either Y or N."
    end
  end
  def save_new_deck
    new_deck = CreateNewDeckFile.new(@raw_string_of_cards)
    loop do
      print "What would you like to save the file as?\n> "
      new_filename = gets.downcase.chomp
      new_filename += ".txt" if new_filename[-4] != '.'
      if new_deck.filename_exist?(new_filename)
        overwrite_file = String.new # Declare variable to determine if user wants to overwrite existing file
        loop do
          puts "That file already exists.  Would you like to overwrite it (Y/N)?"
          print "> "
          overwrite_file = gets.downcase.chomp
          break if overwrite_file == 'y' || overwrite_file == 'n'
          puts "You must enter either Y or N."
        end
        if overwrite_file == 'y'
          new_deck.filename_exist?(new_filename, true) # Telling the program to save the file name regardless of whether or not it already exists
          new_deck.save_file
          break
        else # Prompts user to enter new file name and does not overwrite existing file
          puts "Please enter a new file name."
        end
      else
        new_deck.save_file
        break
      end
    end
  end
end
class CreateNewDeckFile
  def initialize(string_of_cards)
    @string_of_cards = string_of_cards
  end
  def filename_exist?(filename, overwrite = false)  # Only saves file name if it is a new file... OR the user says it is okay to overwrite the file.
    @filename = filename if File.exist?(filename) == false || overwrite == true
    return File.exist?(filename) if overwrite == false
    File.exist?(filename)
  end
  def save_file
    File.new(@filename, "w")
    File.open(@filename, "w") {|cards| cards.puts @string_of_cards}
    puts "#{@filename.capitalize} has successfully been saved."
  end
end
