require_relative 'card_generator'
require_relative 'create_new_deck'

class UploadSavedDeck
  def read_file
    print "Enter the name of the deck file now, or enter a new name to create a new deck.\n> "
    @filename = gets.downcase.chomp
    validate_filename
    if File.exist?(@filename)
      CardGenerator.new(@filename).cards if File.exist?(@filename)
    else
      file_does_not_exist
    end
  end

  def validate_filename
    name_and_extension = @filename.split('.')
    return @filename += ".txt" if name_and_extension.count == 1
    if name_and_extension[1] == "txt"
      @filename
    else
      puts "Sorry. Only .txt files are supported at this time.\nPlease try again."
      read_file
    end
  end

  def file_does_not_exist
    print "#{@filename} does not yet exist. Would you like to create a new deck (Y/N)?\n> "
    response = gets.chomp.upcase
    if response == 'Y'
      CreateNewDeck.new.create_deck
    else
      puts "No problem. Let's try again."
      read_file
    end
  end
end
