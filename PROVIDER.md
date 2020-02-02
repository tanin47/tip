Make the provider script
=========================

### TL;DR 

* The provider script is an executable binary at `~/Library/Application\ Scripts/tanin.tip/provider.script` that prints JSON on stdout
  * The directory is `~/Library/Application\ Scripts/tanin.tip`, and the file is `provider.script`.
* The provider script is executed by Tip when activated
* Don't forget to `chmod 755 ~/Library/Application\ Scripts/tanin.tip/provider.script`
* Use hard link, not symbolic link (i.e. `ln -s`), because Tip runs in [App Sandbox](https://developer.apple.com/app-sandboxing/) and can't follow a symbolic link to a file outside the predefined directory, which is `~/Library/Application\ Scripts/tanin.tip/`.
* Lastly, don't forget to enable Tip:
  * Go to System Preferences > Keyboard > Shortcuts > Services > Scroll down to the "Text" section. You should see "Tip: open tips" under the "Text" section. Please make sure to check it.


Example
--------

Here's `~/Library/Application\ Scripts/tanin.tip/provider.script` written in Ruby:

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

* Try running `~/Library/Application\ Scripts/tanin.tip/provider.script [some-input]` in Terminal to see if it works correctly
* Open Console.app and set filter Process=Tip. The logs from Tip will show up.
