import XCTest

class TipUITest: XCTestCase {

  let pasteBoard = NSPasteboard.general
  let app = XCUIApplication()

  override func setUp() {
    pasteBoard.clearContents()
    pasteBoard.setString("", forType: .string)
  }

  override func tearDown() {
  }

  func testGoodProvider() {
    launch(withName: "good_provider")
    app.popovers.element.tableRows.firstMatch.cells.firstMatch.click()
    XCTAssertEqual("Return TestInput", pasteBoard.string(forType: .string))
  }

  func testNoProvider() {
    launch(withName: "no_provider", force: true)

    XCTAssertEqual("no_provider doesn't exist. Please make a provider script. Click to see instruction.", app.popovers.children(matching: .any).element(boundBy: 1).firstMatch.value as! String)

    app.popovers.element.click()
    sleep(1)
    XCTAssertEqual("OpenProviderInstruction", pasteBoard.string(forType: .string))
  }

  func testPerformanceExample() {
    self.measure {
    }
  }

  private func launch(withName: String, force: Bool = false){
    let file = Bundle(for: type(of: self)).path(forResource: withName, ofType: "rb")

    guard let valid = file else {
      app.launchArguments = ["-test", "TestInput", "-provider", withName]
      app.launch()
      return
    }

    app.launchArguments = ["-test", "TestInput", "-provider", valid]
    app.launch()
  }
}
