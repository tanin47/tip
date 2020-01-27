Make the provider script
=========================

### TL;DR 

* The provider script is an executable at `~/Library/tanin.tip/provider` that prints JSON on stdout
* The provider script is executed by Tip when activated
* Don't forget to `chmod 755 ~/Library/tanin.tip/provider`


Example
--------

Here's `~/Library/tanin.tip/provider` written in Ruby:

```ruby
#!/usr/bin/env ruby

require 'json'

def main(input)
  items = [
    {type: 'text', value:'Some text'},
    {type: 'url', label:'Open Google', value: "https://google.com/search?q=#{input}"}
  ]

  puts items.to_json
end

if __FILE__ == $0
  main(ARGV[0])
end
```

From the script above, when activating Tip, we'll see:

![Example](example.png)


Output JSON Spec
-----------------

For text, it must contains `"type": "text"` and the field `value`.

For URL, it must contains `"type": "url"` and the fields `label` and `value`.

The JSON must be an array that looks like below:

```json
[
  {"type": "text", "value": "Some text"},
  {"type": "url", "label": "Go to JIRA", "value": "https://your-jira-url/JIRA-0001"},
]
```

Happy programming!


Debugging Tips
---------------

* Try running `~/Library/tanin.tip/provider [some-input]` in Terminal to see if it works correctly
* Open Console.app and set filter Process=Tip. The logs from Tip will show up.
