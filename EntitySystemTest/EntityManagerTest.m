//
//  MonsterWars - EntityManagerTest.m
//  Copyright 2013 Razeware LLC. All rights reserved.
//
//  Created by: Sufiyan Yasa
//

    // Class under test
#import "EntityManager.h"

    // Collaborators
#import "Entity.h"
#import "Component.h"

    // Test support
#import <SenTestingKit/SenTestingKit.h>



@interface EntityManagerTest : SenTestCase
@end

@implementation EntityManagerTest
{
    // test fixture ivars go here
    EntityManager *sut;
}

- (void)setUp
{
    [super setUp];
    sut = [EntityManager defaultManager];
}

- (void)testCreateDefaultEntityManger
{
    // then
    STAssertNotNil(sut,@"EntityManager should not be nil");
}

- (void)testCreateEntityisNotEmpty
{
    // when
    Entity *entity = [sut createEntity];
    
    // then
    STAssertNotNil(entity, @"Entity must not be nil");
    STAssertTrue(entity.eid, @"Entity eid must not be 0");
}

- (void)testRemoveEntity
{
    // given
    Entity *entity = [sut createEntity];
    // then
    [sut removeEntity:entity];
}

- (void)testAddComponent
{
    // given
    Component *component = [[Component alloc]init];
    Entity *entity = [sut createEntity];
    uint32_t eid = entity.eid;
    // when
    [sut addComponent:component toEntity:entity];
    
    // then
    NSArray *arr = [sut getAllEntitiesPosessingComponentOfClass:[Component class]];
    Entity *iEid = arr[0];
    STAssertTrue(iEid.eid == eid, @"Component added");
}

@end
