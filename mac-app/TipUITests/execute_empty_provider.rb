#!/usr/bin/env ruby

require 'json'

def main(args)
  if args[0] == '--execute'
    IO.popen('pbcopy', 'w') { |f| f << "from_execute:#{args.join('_')}" }
    puts [].to_json
    return
  end
    
  input = args[0]
  puts [
    {
       type: 'execute',
       label: "Execute #{input}",
       args: ['--execute', 'testempty']
    }
  ].to_json
end


if __FILE__ == $0
  main(ARGV)
end
