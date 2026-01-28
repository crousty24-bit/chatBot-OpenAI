require "dotenv/load"
require "openai"

class OpenAIClient
  def initialize(model: ENV["OPENAI_MODEL"] || "gpt-3.5-turbo-instruct")
    token = ENV["OPENAI_API_KEY"] || ENV["OPENAI_ACCESS_TOKEN"]
    raise "Missing OPENAI_API_KEY in .env" unless token

    org = ENV["OPENAI_ORG_ID"]

    @client = OpenAI::Client.new(access_token: token, organization_id: org)
    @model = model
  end

  def complete(prompt, max_tokens:, temperature:, n: 1)
    @client.completions(
      parameters: {
        model: @model,
        prompt: prompt,
        max_tokens: max_tokens,
        temperature: temperature,
        n: n
      }
    ).fetch("choices").first.fetch("text").strip
  end
end