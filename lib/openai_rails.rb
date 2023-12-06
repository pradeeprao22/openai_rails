# frozen_string_literal: true

require_relative "openai_rails/version"
require 'openai'

module OpenaiRails
  class Error < StandardError; end

  class << self
    attr_accessor :api_key
  end

  def self.configure
    yield self
  end

  def self.generate_response(prompt, model = 'text-davinci-002', max_tokens: 150)
    Openai.configure { |config| config.api_key = api_key }
    response = Openai.Completion.create(
      engine: model,
      prompt: prompt,
      max_tokens: max_tokens
    )

    response['choices'][0]['text']
  end
end
