![Universal Tip icon](./app-icon.png) Universal Tip
==============

[![Download from Mac App Store](./download-button.svg)](https://apps.apple.com/us/app/universal-tip/id1495732622)

Tip (or its full name, Universal Tip) is a programmable tooltip that can be used with any Mac OS app. You can select the text and hit the shortcuts to activate a tooltip with useful info.

"Useful info" is programmed by you using your favourite programming language. 

For me, who is prone to [Repetitive strain injury](https://www.nhs.uk/conditions/repetitive-strain-injury-rsi/) and [Carpal tunnel syndrome](https://www.webmd.com/pain-management/carpal-tunnel/carpal-tunnel-syndrome), Tip reduces hand movement which helps reduce the risk of the injury.

I'd love for you to try it!

Questions? please don't hesitate to open [a Github issue](https://github.com/tanin47/tip/issues).


Examples
---------

### Convert the seconds from epoch to the human-readable time and copy it to clipboard

Tip is used within Chrome.

![Convert seconds from epoch to time and copy](https://media.giphy.com/media/f952ZuRG9kqCoxGt8v/giphy.gif)

### Open Github code search on the selected text

Tip is used within Sublime.

![Open Github code search with the selected text](https://media.giphy.com/media/cjif6axsDr7tEaP0EF/giphy.gif)

### Open a file on Github from an error stacktrace line

Tip is used within Terminal.

![Open file on Github from an error stacktrace line](https://media.giphy.com/media/JSYWptFElQmDJOXzXO/giphy.gif)

### Open a JIRA ticket on the selected text

Tip is used within Terminal.

![Open JIRA with the selected text](https://media.giphy.com/media/H48pYa5PddvEY9MGP6/giphy.gif)

You can make your own info provider. The possibility is endless!


Installation
-------------

1. Install Tip from [Mac App Store](https://apps.apple.com/us/app/universal-tip/id1495732622)
    * You can also download it from [the release page](https://github.com/tanin47/tip/releases) and move `Tip.app` to under `/Applications`
2. Download and copy `scripts/provider.script` to `~/Library/Application\ Scripts/tanin.tip/provider.script`. Run `chmod 755 ~/Library/Application\ Scripts/tanin.tip/provider.script`. 
    * Or you can simply run: `curl -o ~/Library/Application\ Scripts/tanin.tip/provider.script --create-dirs  https://raw.githubusercontent.com/tanin47/tip/master/scripts/provider.script && chmod 755 ~/Library/Application\ Scripts/tanin.tip/provider.script`
3. Go to System Preferences > Keyboard > Shortcuts > Services > Scroll down to the "Text" section. You should see "Tip: open tips" under the "Text" section. 
    * Please make sure to check it.
    * You can also set the shortcuts here.

The sample provider script is in Ruby, so you need Ruby to run it. Otherwise, you can make your own provider as well.

See how to develop [the provider script here](PROVIDER.md).


Privacy
---------

There are 3 components that enables Tip to maintain a high degree of privacy: [App Sandbox](https://developer.apple.com/app-sandboxing/), [NSService](https://developer.apple.com/design/human-interface-guidelines/macos/extensions/services/), and [NSUserUnixTask](https://developer.apple.com/documentation/foundation/nsuserunixtask?language=objc)

1. Tip runs in [App Sandbox](https://developer.apple.com/app-sandboxing/) without requesting for an additional permission. With App Sandbox, Tip can only read/write files from [a few predefined directories](https://developer.apple.com/library/archive/documentation/Security/Conceptual/AppSandboxDesignGuide/AppSandboxInDepth/AppSandboxInDepth.html) and, specifically, can *only* execute (not write) the files within `~/Library/Application\ Scripts/tanin.tip`. This is the reason why the provider script is under `~/Library/Application\ Scripts/tanin.tip/`.

2. Tip is based on [NSServices](https://developer.apple.com/design/human-interface-guidelines/macos/extensions/services/). Tip doesn't (and cannot) see the content of other applications. When you explicit trigger Tip, Mac OS gives Tip the selected text.

3. Tip uses [NSUserUnixTask](https://developer.apple.com/documentation/foundation/nsuserunixtask?language=objc), which is intended to execute user-supplied scripts, and will execute them outside of the application's sandbox, if any. This enables `provider.script` (a user-supplied script) many more use cases because it runs outside of the sandbox.

Great design by Apple. It is a huge win in terms of privacy.


Usage
------

1. Select the text
2. Hit the configured short key. The default shortcut is `Cmd + &`.
3. The tooltip with relevant info will show
4. Use arrow keys to choose an item in the tooltip and hit 'Enter' to perform the appropriate action. Alternatively, you can click an item as well

Currently, Tip supports 2 actions: (1) Copy to clipboard if the item is text, and (2) Open URL if the item is URL.


Customize the shortcut
-----------------------
Go to System Preferences > Keyboard > Shortcuts > Services and set the shortcut for "Tip: open tips".

If [your shortcut doesn't include the Command key](https://apple.stackexchange.com/questions/260683/keyboard-shortcut-for-service-only-works-after-i-manually-run-the-service), you will need to activate it manually by:

1. Selecting a text
2. Clicking on the application menu > Services > "Tip: open tips"

Now you'll be able to use the new shortcut for Tip.

Choosing a good shortcut
-------------------------

I've found that `Cmd + F3` is a good shortcut. I haven't encountered an application that uses this shortcut yet.

My setup, which enables me to use Tip seamlessly, is:

* An extra mouse button emits `Cmd + F3`
* 4-finger touch on the trackpad emits `Cmd + F3`

I use [Noo.app](https://gumroad.com/l/tqqlk) to configure my mouse buttons and trackpad.


Technical detail
-----------------

Tip is an [NSServices](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/SysServices/introduction.html#//apple_ref/doc/uid/10000101-SW1). When user selects text and hits the shortcut, the selected text is sent to Tip. Then, Tip invokes the command-line tool with the selected text as the first argument, i.e `~/Library/Application\ Scripts/tanin.tip/provider.script [selected-text]`.

The command-line tool processes the input, decides which info to show, and prints the tip items as JSON that looks like below:

```
[
  {"type": "text", "value": "Some text"},
  {"type": "url", "label": "Go to JIRA", "value": "https://your-jira-url/JIRA-0001"},
]
```

Tip processes the JSON and renders the tooltip at the mouse location.

Tip on the internet
----------------------------

* [Nerd-Spielzeug „Universal Tip“: Programmierbarer Tooltip für macOS](https://www.ifun.de/nerd-spielzeug-universal-tip-programmierbarer-tooltip-fuer-macos-152982/)
* [PopClipのように、macOSのツールチップにRubyでプログラム可能なアクションを表示することが出来る「Universal Tip」がリリース。](https://applech2.com/archives/post-90727.html?amp=1)
* [Show HN: A programmable tooltip on Mac OS](https://news.ycombinator.com/item?id=22919843) posted by myself
* [Universal tooltip on Mac OS X for programmers. Hackable. Work with every app](https://www.reddit.com/r/programming/comments/eqcnq9/universal_tooltip_on_mac_os_x_for_programmers/) also posted by myself


FAQ
----

### Why is Tip written in Objective-C instead of Swift?

Because I don't know how to write Swift. I'd like to switch to Swift though.

### What does Tip mean?

Tip is a Thai word that means magical and divine. The word is derived from the word, divya, which exists in both Pali and Sanskrit.
