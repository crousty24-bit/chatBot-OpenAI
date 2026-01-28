require_relative "lib/openai_client"
require_relative "lib/ui"

client = OpenAIClient.new(model: "gpt-3.5-turbo-instruct")
prompt = <<~PROMPT
  Propose une recette de cuisine simple en 5 étapes.
  Format : une étape courte par ligne, style impératif, pas de texte inutile.
PROMPT

response = client.complete(prompt, max_tokens: 150, temperature: 0.5)
steps = response.split(/\r?\n/).map(&:strip).reject(&:empty?)

puts UI.frame("Hello, voici 1 recette de cuisine aléatoire", UI.bullets(steps))