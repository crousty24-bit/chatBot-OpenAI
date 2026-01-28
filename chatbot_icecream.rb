#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "lib/openai_client"
require_relative "lib/ui"

client = OpenAIClient.new(model: "gpt-3.5-turbo-instruct")
prompt = <<~PROMPT
  Donne 5 parfums de glace différents en russe, un par ligne.
  Sois concret, aucun doublon, pas de phrase d'introduction ni d'excuses.
PROMPT

response = client.complete(prompt, max_tokens: 50, temperature: 0.8)
flavors = response.split(/\r?\n/).map { |flavor| flavor.strip }.reject(&:empty?)

title = "Hello, voici 5 parfums de glace aléatoires"
puts UI.frame(title, UI.bullets(flavors))