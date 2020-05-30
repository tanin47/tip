#!/usr/bin/env ruby

require 'json'

def main(args)
  if args[0] == '--execute'
    puts [
      {
        type: 'text',
        value: "Result #{args.join(' ')}"
      },
      {
        type: 'execute',
        label: "Reexecute #{args.join(' ')}",
        args: ['--execute', 'reexecute']
      }
    ].to_json
    return
  end
    
  input = args[0]
  puts [
    {
       type: 'text',
       value: "Return #{input}"
    },
    {
        type: 'text',
        label: "{\n  \"input\": \"#{input}\",\n  \"other\": true\n}",
        value: "Value #{input}",
    },
    {
       type: 'url',
       label: "Go to #{input}",
       value: "tanintip://#{input}"
    },
    {
       type: 'execute',
       label: "Execute #{input}",
       args: ['--execute', 'test', 'test2']
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
  main(ARGV)
end
