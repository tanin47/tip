//
//  test2UITests.m
//  test2UITests
//
//  Created by Tanin Na Nakorn on 12/28/19.
//  Copyright © 2019 Tanin Na Nakorn. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface tipUITests : XCTestCase

@end

@implementation tipUITests

NSPasteboard* pboard;
XCUIApplication* app;

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    pboard = [NSPasteboard generalPasteboard];
    [pboard clearContents];
    [pboard setString:@"" forType:NSPasteboardTypeString];
    
    app = [[XCUIApplication alloc] init];
    
}

- (void) launchWithProvider:(NSString *)provider {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:provider ofType:@"rb"];
    app.launchArguments = @[@"-test", @"TestInput", @"-provider", path];
    [app launch];
}

- (void)tearDown {
    [app terminate];
}

- (void)testClickingOnText {
    [self launchWithProvider:@"provider"];
    [app.popovers.element.tableRows.firstMatch.cells.firstMatch click];
    XCTAssert([@"Return TestInput" isEqualToString:[pboard stringForType:NSPasteboardTypeString]]);
}

- (void)testClickingOnUrl {
    [self launchWithProvider:@"provider"];
    [[app.popovers.element.tableRows elementBoundByIndex:1].cells.firstMatch click];
    [NSThread sleepForTimeInterval:0.1f];
    XCTAssert([@"tanintip://TestInput" isEqualToString:[pboard stringForType:NSPasteboardTypeString]]);
}

- (void)testNoTips {
    [self launchWithProvider:@"empty_provider"];
    XCTAssert([@"No tips. You can add tips through your provider script. Click to see the instruction." isEqualToString:[[app.popovers childrenMatchingType:XCUIElementTypeAny] elementBoundByIndex:1].firstMatch.value]);
    
    [app.popovers.element click];
    [NSThread sleepForTimeInterval:0.1f];
    XCTAssert([@"OpenProviderInstruction" isEqualToString:[pboard stringForType:NSPasteboardTypeString]]);
}

- (void)testNoProvider {
    app.launchArguments = @[@"-test", @"TestInput", @"-provider", @"/tmp/some-non-existent-provider.rb"];
    [app launch];
    XCTAssert([@"/tmp/some-non-existent-provider.rb doesn't exist. Please make a provider script. Click to see instruction." isEqualToString:[[app.popovers childrenMatchingType:XCUIElementTypeAny] elementBoundByIndex:1].firstMatch.value]);
    
    [app.popovers.element click];
    [NSThread sleepForTimeInterval:0.1f];
    XCTAssert([@"OpenProviderInstruction" isEqualToString:[pboard stringForType:NSPasteboardTypeString]]);
}

- (void)testUnexecutableProvider {
    [self launchWithProvider:@"unexecutable_provider"];
    XCTAssert([(NSString*)[[app.popovers childrenMatchingType:XCUIElementTypeAny] elementBoundByIndex:1].firstMatch.value containsString:@"Provider isn't executable. Please chmod 755"]);
    
    [app.popovers.element click];
    [NSThread sleepForTimeInterval:0.1f];
    XCTAssert([@"None" isEqualToString:[pboard stringForType:NSPasteboardTypeString]]);
}

- (void)testMalformedJson {
    [self launchWithProvider:@"malformed_json_provider"];
    XCTAssert([@"Malformed JSON returned from provider. Click to see logs in Console. You'll need to set the filter Process=Tip." isEqualToString:[[app.popovers childrenMatchingType:XCUIElementTypeAny] elementBoundByIndex:1].firstMatch.value]);
    
    [app.popovers.element click];
    [NSThread sleepForTimeInterval:0.1f];
    XCTAssert([@"OpenConsole" isEqualToString:[pboard stringForType:NSPasteboardTypeString]]);
}

- (void)testError {
    [self launchWithProvider:@"error_provider"];
    XCTAssert([@"Error occurred. Click to see logs in Console. You'll need to set the filter Process=Tip." isEqualToString:[[app.popovers childrenMatchingType:XCUIElementTypeAny] elementBoundByIndex:1].firstMatch.value]);
    
    [app.popovers.element click];
    [NSThread sleepForTimeInterval:0.1f];
    XCTAssert([@"OpenConsole" isEqualToString:[pboard stringForType:NSPasteboardTypeString]]);
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[XCTOSSignpostMetric.applicationLaunchMetric] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
