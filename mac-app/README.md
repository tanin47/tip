* Running tests: `xcodebuild -scheme "debug" test`
* Run `/System/Library/CoreServices/pbs -update` to update the list of services.
* Run `/System/Library/CoreServices/pbs -dump` to see the list of services.
* Debug UI tree: `print(app.debugDescription)` or print `.debugDescription` on any `XCUIElement` and `XCUIElementQuery`