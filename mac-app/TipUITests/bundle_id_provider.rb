#!/usr/bin/env ruby

require 'json'

def main(argv)
  puts [
    {
       type: 'text',
       value: "Return #{argv.join(' ')}"
    }
  ].to_json
end


if __FILE__ == $0
  main(ARGV)
end

