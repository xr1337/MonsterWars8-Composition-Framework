//
//  Entity.h
//  MonsterWars
//
//  Created by Sufiyan Yasa on 5/11/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entity : NSObject

- (id)initWithEid:(uint32_t)eid;
- (uint32_t)eid;

@end
