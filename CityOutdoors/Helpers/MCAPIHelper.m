//
//  MCAPIHelper.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 25/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCAPIHelper.h"
#import "RXMLElement.h"

@implementation MCAPIHelper

+(BOOL)isAPIErrorResponse:(id)responseObject {
	NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
	if (responseString.length == 0) {
		return YES;
	}
	RXMLElement *xmlData = [[RXMLElement alloc] initFromXMLString:responseString encoding:NSUTF8StringEncoding];
	NSString *errorString = [xmlData child:@"error"].text;
	if ([errorString isEqualToString:@"No User"]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:USER_LOGGED_OUT_NOTIFICATION object:nil];
		return YES;
	}
	if(errorString != nil) {
		return YES;
	}
	return NO;
}

@end
