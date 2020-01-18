Tip: Universal tooltip for Mac OS X
===================================================

Tip provides useful info at your fingertip. You can simply select the text and hit the shortkey to activate the tooltip showing useful info.

"Useful info" is programmed by you using any programming language, and it works with every Mac app.

Examples
---------

### Convert the seconds from epoch to the human-readable time and copy it to clipboard

![Convert seconds from epoch to time and copy](https://media.giphy.com/media/f952ZuRG9kqCoxGt8v/giphy.gif)

### Open Github code search on the selected text

![Open Github code search with the selected text](https://media.giphy.com/media/cjif6axsDr7tEaP0EF/giphy.gif)

### Open a file on Github from an error stacktrace line

![Open file on Github from an error stacktrace line](https://media.giphy.com/media/JSYWptFElQmDJOXzXO/giphy.gif)

### Open a JIRA ticket on the selected text

![Open JIRA with the selected text](https://media.giphy.com/media/H48pYa5PddvEY9MGP6/giphy.gif)

You can make your own info provider. The possibility is endless!

Usage
------

1. Select the text
2. Hit the configured short key
3. The tooltip with relevant info will show
4. Use arrow keys to choose an item in the tooltip and hit 'Enter' to perform the appropriate action. Alternatively, you can click an item as well

Currently, Tip supports 2 actions: (1) Copy to clipboard if the item is text, and (2) Open URL if the item is URL.


Installation
-------------

1. Download the latest version of `Tip.app` from [the release page](https://github.com/tanin47/tip/releases)
2. Download and copy `scripts/provider` to `~/.tip/provider`. Run `chmod 755 ~/.tip/provider`
3. Go to System Preferences > Keyboard > Shortcuts > Services and set the short key for "Tip: open tips"

If [your short key doesn't include the Command key](https://apple.stackexchange.com/questions/260683/keyboard-shortcut-for-service-only-works-after-i-manually-run-the-service), you will need to activate it manually by:

1. Selecting a text
2. Clicking on the application menu > Services > "Tip: open tips"

Now you'll be able to use the short key for Tip.


Technical detail
-----------------

Tip is a [system-wide service on Mac](https://developer.apple.com/design/human-interface-guidelines/macos/extensions/services/). When user selects text and hits the short key, the selected text is sent to Tip. Then, Tip invokes the command-line tool with the selected text as the first argument, i.e `~/.tip/provider [selected-text]`.

The command-line tool processes the input, decides which info to show, and prints the tip items as JSON that looks like below:

```
[
  {"type": "text", "value": "Some text"},
  {"type": "url", "label": "Go to JIRA", "value": "https://your-jira-url/JIRA-0001"},
]
```

Tip processes the JSON and renders the tooltip at the mouse location.

