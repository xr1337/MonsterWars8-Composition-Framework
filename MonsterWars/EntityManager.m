//
//  EntityManager.m
//  MonsterWars
//
//  Created by Sufiyan Yasa on 5/11/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "EntityManager.h"
#import "Entity.h"
#import "Component.h"


@implementation EntityManager{
    NSMutableSet * _entities;
    NSMutableDictionary * _componentsByClass;
    uint32_t _lowestUnassignedEid;
}

// Returns a default entity that can be globally used.
// For custom entities, clients may generate their own
+ (EntityManager *)defaultManager {
    static EntityManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[EntityManager alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init {
    if ((self = [super init])) {
        _entities = [NSMutableArray array];
        _componentsByClass = [NSMutableDictionary dictionary];
        _lowestUnassignedEid = 1;
    }
    return self;
}

// creates a new Entity ID. If there are no more entity IDs, then return 0.
- (uint32_t) generateNewEid {
    if (_lowestUnassignedEid < UINT32_MAX) {
        return _lowestUnassignedEid++;
    } else {
        for (uint32_t i = 1; i < UINT32_MAX; ++i) {
            if (![_entities containsObject:@(i)]) {
                return i;
            }
        }
        return 0;
    }
}

// creates a new entity
- (Entity *)createEntity {
    uint32_t eid = [self generateNewEid];
    [_entities addObject:@(eid)];
    return [[Entity alloc] initWithEid:eid];
}

// adds a single component to the entity
- (void)addComponent:(Component *)component toEntity:(Entity *)entity {
    NSMutableDictionary * components = _componentsByClass[NSStringFromClass([component class])];
    if (!components) {
        components = [NSMutableDictionary dictionary];
        _componentsByClass[NSStringFromClass([component class])] = components;
    }
    components[@(entity.eid)] = component;
}

// Helper method to query an entity
- (Component *)getComponentOfClass:(Class)class forEntity:(Entity *)entity {
    return _componentsByClass[NSStringFromClass(class)][@(entity.eid)];
}

// Remove entity
- (void)removeEntity:(Entity *)entity {
    for (NSMutableDictionary * components in _componentsByClass.allValues) {
        if (components[@(entity.eid)]) {
            [components removeObjectForKey:@(entity.eid)];
        }
    }
    [_entities removeObject:@(entity.eid)];
}

// Helper method to query all entities
- (NSArray *)getAllEntitiesPosessingComponentOfClass:(Class)class {
    NSMutableDictionary * components = _componentsByClass[NSStringFromClass(class)];
    if (components) {
        NSMutableArray * retval = [NSMutableArray arrayWithCapacity:components.allKeys.count];
        for (NSNumber * eid in components.allKeys) {
            [retval addObject:[[Entity alloc] initWithEid:eid.integerValue]];
        }
        return retval;
    } else {
        return [NSArray array];
    }
}
@end
