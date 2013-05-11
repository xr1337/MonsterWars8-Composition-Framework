//
//  System.m
//  MonsterWars
//
//  Created by Sufiyan Yasa on 5/11/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "System.h"
#import "EntityManager.h"

@implementation System

- (id)initWithEntityManager:(EntityManager *)entityManager {
    if ((self = [super init])) {
        self.entityManager = entityManager;
    }
    return self;
}

- (void)update:(float)dt {
}

@end
