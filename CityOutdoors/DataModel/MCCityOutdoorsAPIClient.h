//
//  MCCityOutdoorsAPIClient.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 30/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "AFHTTPClient.h"

@interface MCCityOutdoorsAPIClient : AFHTTPClient

+ (MCCityOutdoorsAPIClient *)sharedClient;
-(void)postComment:(NSString *)comment
		forFeatureID:(NSNumber*)featureID
			  name:(NSString*)name
			 photo:(UIImage*)photo
		completion:(void (^)(BOOL success, NSError *error))completionBlock;

-(void)postReport:(NSString *)comment
		forFeatureID:(NSNumber*)featureID
			  name:(NSString*)name
            email:(NSString *)email
			 photo:(UIImage*)photo
		completion:(void (^)(BOOL success, NSError *error))completionBlock;

-(NSURL*)forgottenPasswordURL;
-(NSURL*)createAccountURL;

-(void)loginWithEmail:(NSString*)email
		  andPassword:(NSString*)password
		   completion:(void (^)(BOOL success, NSError *error))completionBlock;

-(void)favouriteFeatureWithID:(NSNumber*)featureID
			  completionBlock:(void (^)(BOOL success,NSError *error))completionBlock;

-(void)postQuestionWithID:(NSNumber*)questionID
				   answer:(NSString*)answer
		  completionBlock:(void (^)(BOOL success,BOOL isCorrectResponse,NSError *error))completionBlock;
@end
