#!/usr/bin/env ruby

require 'json'

def main(input)
  puts [
    {
       type: 'text',
       label: "Label #{input}",
       value: "Return #{input}"
    }
  ].to_json
end


if __FILE__ == $0
  main(ARGV[0])
end
