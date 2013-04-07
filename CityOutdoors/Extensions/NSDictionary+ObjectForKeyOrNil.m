//
//  NSDictionary+ObjectForKeyOrNil.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 29/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "NSDictionary+ObjectForKeyOrNil.h"

@implementation NSDictionary (ObjectForKeyOrNil)

- (id)objectForKeyOrNil:(id)key {
    id val = [self objectForKey:key];
    if ([val isEqual:[NSNull null]]) {
        return nil;
    }    
    return val;
}

@end
