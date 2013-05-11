//
//  MonsterWars - ComponentTest.m
//  Copyright 2013 Razeware LLC. All rights reserved.
//
//  Created by: Sufiyan Yasa
//

    // Class under test
#import "Component.h"

    // Collaborators

    // Test support
#import <SenTestingKit/SenTestingKit.h>


@interface ComponentTest : SenTestCase
@end

@implementation ComponentTest
{
    // test fixture ivars go here
    Component *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[Component alloc]init];
}

- (void)testNotNil
{
    // then
    STAssertNotNil(sut, @"Component should not be NIL");
}
@end
