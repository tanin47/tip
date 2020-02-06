![Universal Tip icon](./app-icon.png) Universal Tip
==============

[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/tanin-tip/community#)

[![Download from Mac App Store](./download-button.svg)](https://apps.apple.com/us/app/universal-tip/id1495732622)

Universal Tip provides useful info at your fingertip. You can simply select the text and hit the shortkey to activate the tooltip with useful info.

"Useful info" is programmed by you using your fav programming language, and it works with every Mac app.

For me, who is prone to Repetitive Strain Injury (RSI), Tip reduces hand movement and, thus, the risk of the injury. It also makes me work faster. I encourage you to try Tip today!


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


Installation
-------------

1. Install Tip from [Mac App Store](https://apps.apple.com/us/app/universal-tip/id1495732622)
    * You can also download it from [the release page](https://github.com/tanin47/tip/releases) and move `Tip,app` to under `/Applications`
2. Download and copy `scripts/provider.script` to `~/Library/Application\ Scripts/tanin.tip/provider.script`. Run `chmod 755 ~/Library/Application\ Scripts/tanin.tip/provider.script`. 
    * Or you can simply run: `curl -o ~/Library/Application\ Scripts/tanin.tip/ --create-dirs  https://raw.githubusercontent.com/tanin47/tip/master/scripts/provider.script && chmod 755 ~/Library/Application\ Scripts/tanin.tip/provider.script`
3. Go to System Preferences > Keyboard > Shortcuts > Services > Scroll down to the "Text" section. You should see "Tip: open tips" under the "Text" section. 
    * Please make sure to check it.
    * You can also set the short key here.

The sample provider script is in Ruby, so you need Ruby to run it. Otherwise, you can simply make your own provider as well.

See how to develop the provider [here](PROVIDER.md).


Privacy
---------

Tip runs in [App Sandbox](https://developer.apple.com/app-sandboxing/), which protects users by limiting the privileges of the app to its intended functionality. App Sandbox gives our users peace of mind.

With App Sandbox, Tip can only read/write files from [a few predefined directories](https://developer.apple.com/library/archive/documentation/Security/Conceptual/AppSandboxDesignGuide/AppSandboxInDepth/AppSandboxInDepth.html) and, specifically, can *only* execute files (not write) within `~/Library/Application\ Scripts/tanin.tip`.

This is the reason why the provider script is under `~/Library/Application\ Scripts/tanin.tip/`.

As a reminder, please always review a downloaded provider script before using it.


Usage
------

1. Select the text
2. Hit the configured short key. The default short key is `Cmd + &`.
3. The tooltip with relevant info will show
4. Use arrow keys to choose an item in the tooltip and hit 'Enter' to perform the appropriate action. Alternatively, you can click an item as well

Currently, Tip supports 2 actions: (1) Copy to clipboard if the item is text, and (2) Open URL if the item is URL.


Customize the short key
------------------------

Go to System Preferences > Keyboard > Shortcuts > Services and set the short key for "Tip: open tips".

If [your short key doesn't include the Command key](https://apple.stackexchange.com/questions/260683/keyboard-shortcut-for-service-only-works-after-i-manually-run-the-service), you will need to activate it manually by:

1. Selecting a text
2. Clicking on the application menu > Services > "Tip: open tips"

Now you'll be able to use the new short key for Tip.


Technical detail
-----------------

Tip is a [system-wide service on Mac](https://developer.apple.com/design/human-interface-guidelines/macos/extensions/services/). When user selects text and hits the short key, the selected text is sent to Tip. Then, Tip invokes the command-line tool with the selected text as the first argument, i.e `~/Library/Application\ Scripts/tanin.tip/provider.script [selected-text]`.

The command-line tool processes the input, decides which info to show, and prints the tip items as JSON that looks like below:

```
[
  {"type": "text", "value": "Some text"},
  {"type": "url", "label": "Go to JIRA", "value": "https://your-jira-url/JIRA-0001"},
]
```

Tip processes the JSON and renders the tooltip at the mouse location.


FAQ
----

### Why is Tip written in Objective-C instead of Swift?

Because I don't know how to write Swift. I'd like to switch to Swift though.
