//
//  MCCredentialStore.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 05/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCredentialStore : NSObject
- (BOOL)isLoggedIn;
- (void)clearSavedCredentials;
- (NSString *)authToken;
- (void)setAuthToken:(NSString *)authToken;
- (NSString*)email;
- (void)setEmail:(NSString*)email;
- (NSString*)name;
- (void)setName:(NSString*)name;
- (NSNumber*)userID;
- (void)setUserID:(NSNumber*)userID;
@end
