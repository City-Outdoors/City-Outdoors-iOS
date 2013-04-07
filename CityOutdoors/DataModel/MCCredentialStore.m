//
//  MCCredentialStore.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 05/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCCredentialStore.h"
#import "SSKeychain.h"

#define SERVICE_NAME @"MCCityOutdoors"
#define AUTH_TOKEN_KEY @"auth_token"
#define EMAIL_KEY @"email"
#define NAME_KEY @"name"
#define USER_ID @"userID"


@implementation MCCredentialStore
- (BOOL)isLoggedIn {
    return [self authToken] != nil && [self userID] != nil && [self name] != nil;
}

- (void)clearSavedCredentials {
    [self setAuthToken:nil];
	[self setEmail:nil];
	[self setName:nil];
	[self setUserID:nil];
}

- (NSString *)authToken {
    return [self secureValueForKey:AUTH_TOKEN_KEY];
}

- (void)setAuthToken:(NSString *)authToken {
    [self setSecureValue:authToken forKey:AUTH_TOKEN_KEY];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"token-changed" object:self];
}

- (NSString*)email {
	return [self secureValueForKey:EMAIL_KEY];
}

- (void)setEmail:(NSString*)email {
	[self setSecureValue:email forKey:EMAIL_KEY];
}

- (NSString*)name {
	return [self secureValueForKey:NAME_KEY];

}

- (void)setName:(NSString*)name {
	[self setSecureValue:name forKey:NAME_KEY];
}


- (NSNumber*)userID {
	return @([self secureValueForKey:USER_ID].integerValue);
}
- (void)setUserID:(NSNumber*)userID {
	[self setSecureValue:userID.stringValue forKey:USER_ID];
}


#pragma mark - private methods

- (void)setSecureValue:(NSString *)value forKey:(NSString *)key {
    if (value) {
        [SSKeychain setPassword:value
                     forService:SERVICE_NAME
                        account:key];
    } else {
        [SSKeychain deletePasswordForService:SERVICE_NAME account:key];
    }
}

- (NSString *)secureValueForKey:(NSString *)key {
    return [SSKeychain passwordForService:SERVICE_NAME account:key];
}

@end
