#!/usr/bin/env ruby

require 'json'

def main(input)
  puts [
    {
       type: 'text',
       label: "Label Auto #{input}",
       value: "Return Auto #{input}",
       executeIfOnlyOne: TRUE
    }
  ].to_json
end


if __FILE__ == $0
  main(ARGV[0])
end

