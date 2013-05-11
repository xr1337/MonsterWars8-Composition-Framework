//
//  System.h
//  MonsterWars
//
//  Created by Sufiyan Yasa on 5/11/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntityManager;

@interface System : NSObject

@property (strong) EntityManager * entityManager;

- (id)initWithEntityManager:(EntityManager *)entityManager;
- (void)update:(float)dt;

@end
