class CreateNewDeckFile
  def initialize(string_of_cards)
    @string_of_cards = string_of_cards
  end

  def filename_exist?(filename, overwrite = false)
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
