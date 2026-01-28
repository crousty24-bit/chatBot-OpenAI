# ChatBot OpenAI

A Ruby-based chatbot application that integrates with the OpenAI API to generate intelligent responses. This project provides a reusable OpenAI client wrapper with example implementations for various use cases.

## Features

- Simple OpenAI API integration via the HTTP gem
- Configurable API parameters (temperature, max tokens, model selection)
- Environment-based configuration using .env files
- Example implementations for recipe generation and other text completion tasks
- Support for multiple OpenAI models

## Prerequisites

- Ruby 3.4.2 or higher
- An OpenAI API key
- Bundler for dependency management

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/chatBot-OpenAI.git
cd chatBot-OpenAI
```

2. Install dependencies:
```bash
bundle install
```

3. Create a `.env` file in the project root with your OpenAI API key:
```bash
OPENAI_API_KEY=your_api_key_here
```

## Configuration

The OpenAI client is configured in `lib/app.rb`. You can customize the following parameters when calling the `complete()` method:

- `prompt`: The input text for completion
- `max_tokens`: Maximum length of the generated response (default: 50)
- `temperature`: Controls randomness of responses (0.0-1.0, default: 0.3)
- `model`: The OpenAI model to use (default: "babbage-002")

## Usage

### Basic Example

```ruby
require_relative "lib/app"

client = OpenAIClient.new
response = client.complete(
  "What is Ruby?",
  max_tokens: 150,
  temperature: 0.5
)

puts response
```

### Recipe Generation Example

Run the included recipe generator:

```bash
ruby chat-bot-glace.rb
```

This script requests a 5-step recipe from OpenAI and displays each step numbered.

## Project Structure

```
.
├── Gemfile                 # Project dependencies
├── README.md              # This file
├── lib/
│   └── app.rb            # OpenAI client implementation
├── spec/
│   └── spec_helper.rb    # Test configuration
└── chat-bot-glace.rb     # Example: recipe generator script
```

## Dependencies

- `http` - HTTP client for API requests
- `json` - JSON parsing
- `dotenv` - Environment variable management
- `ruby-openai` - OpenAI API wrapper (optional)
- `rspec` - Testing framework
- `rubocop` - Code linting

## Examples

### Custom Prompt

Create a new script with your own prompt:

```ruby
require_relative "lib/app"

client = OpenAIClient.new
prompt = "Generate a creative story about a robot"

response = client.complete(prompt, max_tokens: 200, temperature: 0.8)
puts response
```

### Parsing Structured Output

Process the response into structured data:

```ruby
response = client.complete(your_prompt, max_tokens: 150)
lines = response.split(/\r?\n/).map(&:strip).reject(&:empty?)
lines.each_with_index do |line, index|
  puts "#{index + 1}. #{line}"
end
```

## Error Handling

Ensure your `OPENAI_API_KEY` environment variable is set before running scripts. If you receive authentication errors, verify that:

1. Your API key is valid and active
2. The `.env` file is in the correct location
3. Dotenv has successfully loaded the environment variables

## Testing

Run tests with:

```bash
bundle exec rspec
```

## Contributing

Contributions are welcome. Please ensure code follows the project's standards by running:

```bash
bundle exec rubocop
```