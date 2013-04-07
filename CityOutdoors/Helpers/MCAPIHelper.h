//
//  MCAPIHelper.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 25/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_LOGGED_OUT_NOTIFICATION @"UserLoggedOutNotification"

@interface MCAPIHelper : NSObject
+(BOOL)isAPIErrorResponse:(id)responseObject;
@end
