#!/usr/bin/env ruby

# Please copy this file to the folder: ~/Library/Application\ Scripts/tanin.tip/

require 'json'
require 'cgi'

def main(input)
  input = input.strip.force_encoding('UTF-8')
  # The force encoding prevents the error: ASCII-8BIT to UTF-8 (Encoding::UndefinedConversionError)

  items = [
      {
           type: 'text',
           label: 'Copy uppercase',
           value: input.upcase
      },
      {
           type: 'text',
           label: 'Copy lowercase',
           value: input.downcase
      },
      {
           type: 'url',
           label: "Open Google Search for: #{input}",
           value: "https://google.com/search?q=#{CGI.escape(input)}"
      },
  ]

  puts items.compact.to_json
end

if __FILE__ == $0
  main(ARGV[0])
end

