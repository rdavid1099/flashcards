require_relative 'cards'

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
