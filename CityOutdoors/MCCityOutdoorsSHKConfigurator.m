//
//  MCCityOutdoorsSHKConfigurator.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 27/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCCityOutdoorsSHKConfigurator.h"

@implementation MCCityOutdoorsSHKConfigurator

/*
 App Description
 ---------------
 These values are used by any service that shows 'shared from XYZ'
 */
- (NSString*)appName {
#warning Update the app name when sharing via Twitter/Facebook
	return @"City Outdoors iOS App";
}

- (NSString*)appURL {
#warning Update the app URL when sharing via Twitter/Facebook

	return @"http://www.yolocode.com";
}

- (NSString*)facebookAppId {
#warning Add a Facebook app id to share features on Facebook. Make sure you set up single sign on in the CityOutdoors-Info.plist URLs
	return @"";
}

- (NSArray*)defaultFavoriteURLSharers {
    return @[@"SHKMail",@"SHKTwitter",@"SHKFacebook"];
}

/*
 by default, user can see last used sharer on top of the SHKActionSheet. You can switch this off here, so that user is always presented the same sharers for each SHKShareType.
*/
- (NSNumber*)autoOrderFavoriteSharers {
    return @(YES);
}

- (NSNumber*)showActionSheetMoreButton {
	return @(NO);
/*
 Setting this to true will show More... button in SHKActionSheet, setting to false will leave the button out.
*/
}

@end
