//
//  EntityManager.h
//  MonsterWars
//
//  Created by Sufiyan Yasa on 5/11/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  Entity;
@class Component;

@interface EntityManager : NSObject

+ (EntityManager *)defaultManager;

- (Entity *)createEntity;

- (void)addComponent:(Component *)component toEntity:(Entity *)entity;

- (Component *)getComponentOfClass:(Class)class forEntity:(Entity *)entity;

- (void)removeEntity:(Entity *)entity;

- (void)removeAllEntities;

- (NSArray *)getAllEntitiesPosessingComponentOfClass:(Class)class;

@end
