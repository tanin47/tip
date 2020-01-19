#!/usr/bin/env ruby

require 'json'

def main(input)
  puts [
    {
       type: 'text',
       value: "Return #{input}"
    },
   {
       type: 'url',
       label: "Go to #{input}",
       value: 'https://tanin.nanakorn.com'
   }
  ].to_json
end


if __FILE__ == $0
  main(ARGV[0])
end
