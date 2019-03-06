module PromptUtil
  def self.prompt(message)
    puts message
    gets.chomp
  end
end