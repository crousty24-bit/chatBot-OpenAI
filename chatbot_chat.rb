require_relative "lib/openai_client"
require_relative "lib/ui"
require "dotenv/load"

SYSTEM_PROMPT = "Réponds en anglais, factuel, concis. Si l'information manque, dis-le."

def converse_with_ai(api_key, conversation_history)
  client = OpenAI::Client.new(access_token: api_key)

  prompt = ([SYSTEM_PROMPT] + conversation_history + ["IA :"]).join("\n")

  response = client.completions(
    parameters: {
      model: "gpt-3.5-turbo-instruct",
      prompt: prompt,
      max_tokens: 500,
      temperature: 0.5,
      n: 1
    }
  )

  response.dig("choices", 0, "text").to_s.strip
end

api_key = ENV["OPENAI_API_KEY"] || ENV["OPENAI_ACCESS_TOKEN"]
raise "Missing OPENAI_API_KEY in .env" unless api_key

conversation_history = []

loop do
  print "Vous : "
  user_input = STDIN.gets&.chomp
  break if user_input.nil? || user_input.downcase == "stop"

  conversation_history << "Utilisateur : #{user_input}"

  answer = converse_with_ai(api_key, conversation_history)
  puts "IA : #{answer}"
  conversation_history << "IA : #{answer}"
end