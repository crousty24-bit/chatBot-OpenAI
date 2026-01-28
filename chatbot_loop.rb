#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "lib/openai_client"
require_relative "lib/ui"

client = OpenAIClient.new(model: "gpt-3.5-turbo-instruct")
QUALITY = "Réponds en anglais, de façon factuelle, précise et concise. Si tu ne sais pas, dis-le."

loop do
  print "Vous : "
  user_prompt = STDIN.gets&.chomp
  break if user_prompt.nil? || user_prompt.downcase == "stop"

  prompt = "#{QUALITY}\n\nQuestion : #{user_prompt}\nRéponse :"
  answer = client.complete(prompt, max_tokens: 200, temperature: 0.2)
  puts UI.frame("IA", answer)
end