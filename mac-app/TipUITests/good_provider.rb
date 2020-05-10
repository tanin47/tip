#!/usr/bin/env ruby

require 'json'

def main(input)
  puts [
    {
       type: 'text',
       value: "Return #{input}"
    },
    {
        type: 'text',
          label: "Label #{input}",
          value: "Value #{input}",
    },
    {
       type: 'url',
       label: "Go to #{input}",
       value: "tanintip://#{input}"
    },
    {
       type: 'text',
       label: "Label Auto #{input}",
       value: "Return Auto #{input}",
       executeIfOnlyOne: true
    }
  ].to_json
end


if __FILE__ == $0
  main(ARGV[0])
end
