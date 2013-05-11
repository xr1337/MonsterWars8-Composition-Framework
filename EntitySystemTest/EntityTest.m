//
//  MonsterWars - EntityTest.m
//  Copyright 2013 Razeware LLC. All rights reserved.
//
//  Created by: Sufiyan Yasa
//

    // Class under test
#import "Entity.h"

    // Collaborators

    // Test support
#import <SenTestingKit/SenTestingKit.h>

@interface EntityTest : SenTestCase
@end

@implementation EntityTest
{
    // test fixture ivars go here
    Entity *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [[Entity alloc]initWithEid:1];
}

- (void)testCreateDoesNotCreateNil
{
    STAssertNotNil(sut, @"Entity is nil");
}

- (void)testRequestEntityId
{
    STAssertTrue(sut.eid == 1, @"Entity ID is not same");
}


@end
