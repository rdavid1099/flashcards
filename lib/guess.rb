class Guess
  attr_reader :card, :response
  def initialize(user_input, card)
    @response = user_input
    @card = card
  end
  def correct?
    @response.downcase == card.answer.downcase # .downcase ensures that answers are NOT case sensitive
  end
  def feedback
    return "Correct!" if correct?
    "Incorrect."
  end
end
