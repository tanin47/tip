#!/usr/bin/env ruby

require 'json'

def main(input)
  puts [
    {
       type: 'url',
       label: "Label Auto URL #{input}",
       value: "tanintip://auto-#{input}",
       autoExecuteIfFirst: true
    },
    {
        type: 'text',
        value: 'second item'
    }
  ].to_json
end


if __FILE__ == $0
  main(ARGV[0])
end

