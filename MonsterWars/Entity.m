//
//  Entity.m
//  MonsterWars
//
//  Created by Sufiyan Yasa on 5/11/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "Entity.h"

@implementation Entity{
    uint32_t _eid;
}

- (id)initWithEid:(uint32_t)eid  {
    if ((self = [super init])) {
        _eid = eid;
    }
    return self;
}

- (uint32_t)eid {
    return _eid;
}

@end
