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

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testClickingOnText {
    NSPasteboard *pboard = [NSPasteboard generalPasteboard];
    [pboard setString:@"" forType:NSPasteboardTypeString];
    
    // UI tests must launch the application that they test.
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"provider" ofType:@"rb"];
    app.launchArguments = @[@"-test", @"Test Input", @"-provider", path];
    [app launch];
    
    [app.popovers.element.tableRows.firstMatch.cells.firstMatch click];
    
    XCTAssert([@"Return Test Input" isEqualToString:[pboard stringForType:NSPasteboardTypeString]]);
    
    [app terminate];
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
