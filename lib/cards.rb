class Card
  attr_reader :question, :answer, :hint
  def initialize(question, answer, hint)
    @question = question
    @answer = answer
    @hint = hint
  end
end

class CardGenerator
  def initialize(file_name)
    @file_name = file_name
  end
  def cards
    cards_in_file = File.read(@file_name).split(/\n/)
    cards_in_file.map {|card| Card.new(card.split(';')[0],card.split(';')[1],card.split(';')[2])}
  end
end

class UploadSavedDeck
  def initialize
    @filename = String.new
  end
  def read_file
    while @filename != '0'
      print "Enter the name of the deck file now.\n> "
      @filename = gets.downcase.chomp
      @filename += ".txt" if @filename[-4] != '.' && @filename != '0' # Adds the .txt extension if the user did not type it in.
      return CardGenerator.new(@filename).cards if File.exist?(@filename) # Save the array of the cards in the text file to local_cards
      return CreateNewDeck.new.create_deck if @filename == '0'
      puts "The file name you entered does not exist.  Please type the correct file name or 0 to create a deck."
      # File name does not exist in the relative directory.  Prompts user to re-enter the file name or type 0 to create a new deck
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
