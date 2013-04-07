//
//  MCAlertHelper.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 12/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCAlertHelper.h"

@implementation MCAlertHelper

+(void)featureNotImplementedYet {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Implemented" message:@"Feature not implemented yet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

@end
