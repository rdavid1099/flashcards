class Card
  attr_reader :question, :answer, :hint
  def initialize(question, answer, hint)
    @question = question
    @answer = answer
    @hint = hint
  end
end
