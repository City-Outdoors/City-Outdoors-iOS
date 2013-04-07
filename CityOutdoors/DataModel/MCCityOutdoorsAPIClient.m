//
//  MCCityOutdoorsAPIClient.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 30/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCCityOutdoorsAPIClient.h"
#import "AFNetworking.h"
#import "RXMLElement.h"
#import "MCCredentialStore.h"
#import "MCAPIHelper.h"

#define DEFAULT_IMAGE_COMPRESSION 0.5  /* 0.0 is max compression where 1.0 is least compression */

#ifdef TEST_SERVER
static NSString * const kAFCityOutdoorsAPIBaseURLString = @"https://www.edinburghoutdoors.org.uk/";
#else
static NSString * const kAFCityOutdoorsAPIBaseURLString = @"https://www.edinburghoutdoors.org.uk/";
#endif
@interface MCCityOutdoorsAPIClient ()
@property (strong,nonatomic) MCCredentialStore *credentials;
@end

@implementation MCCityOutdoorsAPIClient

+ (MCCityOutdoorsAPIClient *)sharedClient {
    static MCCityOutdoorsAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAFCityOutdoorsAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.credentials = [[MCCredentialStore alloc] init];
    [self registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/xml"];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(userLoggedOut)
												 name:USER_LOGGED_OUT_NOTIFICATION
											   object:nil];
    
    return self;
}

-(void)postComment:(NSString *)comment
	  forFeatureID:(NSNumber*)featureID
			  name:(NSString*)name
			 photo:(UIImage*)photo
		completion:(void (^)(BOOL success, NSError *error))completionBlock {

	NSMutableDictionary *queryParameters = [NSMutableDictionary dictionaryWithCapacity:0];
	if (name != nil) {
		[queryParameters setObject:name forKey:@"name"];
	}
	if (comment != nil) {
		[queryParameters setObject:comment forKey:@"comment"];
	}
	if (featureID != nil) {
		[queryParameters setObject:featureID forKey:@"featureID"];	
	}

    [self postContentToPath:@"api/v1/newFeatureContent.php" withPhoto:photo queryParameters:queryParameters completionBlock:completionBlock];

}

- (void)postReport:(NSString *)comment
      forFeatureID:(NSNumber *)featureID
              name:(NSString *)name
             email:(NSString *)email
             photo:(UIImage *)photo
        completion:(void (^)(BOOL, NSError *))completionBlock {

    NSMutableDictionary *queryParameters = [NSMutableDictionary dictionaryWithCapacity:0];
   	if (name != nil) {
   		[queryParameters setObject:name forKey:@"name"];
   	}
   	if (comment != nil) {
   		[queryParameters setObject:comment forKey:@"comment"];
   	}
    if (email != nil) {
        [queryParameters setObject:email forKey:@"email"];
    }
   	if (featureID != nil) {
   		[queryParameters setObject:featureID forKey:@"featureID"];
   	}

    [self postContentToPath:@"api/v1/newFeatureReport.php" withPhoto:photo queryParameters:queryParameters completionBlock:completionBlock];
}

-(NSURL*)forgottenPasswordURL {
	return [self URLForPath:@"forgottenPassword.php"];
}

-(NSURL*)createAccountURL {
	return [self URLForPath:@"signup.php"];
}

-(void)loginWithEmail:(NSString*)email andPassword:(NSString*)password completion:(void (^)(BOOL, NSError *))completionBlock {
	NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] initWithCapacity:2];
	if (email != nil) {
		[queryParams setValue:email forKey:@"email"];
	}
	if (password != nil) {
		[queryParams setValue:password forKey:@"password"];
	}
	[[[self class] sharedClient] postPath:@"api/v1/logInOrSignUp.php"
							   parameters:queryParams
								  success:^(AFHTTPRequestOperation *operation, id responseObject) {

									  if ([MCAPIHelper isAPIErrorResponse:responseObject]) {
										  completionBlock (NO,nil);
									  }else {
										  RXMLElement *responseData = [RXMLElement elementFromXMLData:responseObject];
										  RXMLElement *userData = [responseData child:@"user"];
										  NSNumber *userID = @([userData attribute:@"id"].integerValue);
										  [_credentials setUserID:userID];
										  NSString *authToken = [userData attribute:@"token"];
										  [_credentials setAuthToken:authToken];
										  NSString *email = [userData attribute:@"email"];
										  [_credentials setEmail:email];
										  NSString *name = [userData attribute:@"name"];
										  [_credentials setName:name];
										  if ([_credentials isLoggedIn]) {
											  completionBlock(YES,nil);
										  }
									  }
								  }
								  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
									  completionBlock(NO,error);
								  }];
	
}


-(void)favouriteFeatureWithID:(NSNumber*)featureID
 			  completionBlock:(void (^)(BOOL success,NSError *error))completionBlock {
	NSMutableDictionary *queryParameters = [[NSMutableDictionary alloc] initWithCapacity:2];
	if (featureID != nil) {
		[queryParameters setValue:featureID forKey:@"featureID"];
	}
	NSMutableDictionary *processedQueryParams = [self addCredentialsToParameters:queryParameters];
	
	[[[self class] sharedClient] postPath:@"api/v1/newFeatureFavourite.php"
							   parameters:processedQueryParams
								  success:^(AFHTTPRequestOperation *operation, id responseObject) {
									  if ([MCAPIHelper isAPIErrorResponse:responseObject]) {
										  completionBlock(NO,nil);
									  }else {
										  completionBlock(YES,nil);
									  }
								  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
									  completionBlock(NO,error);
								  }];
}


-(void)postQuestionWithID:(NSNumber*)questionID
				   answer:(NSString*)answer
		  completionBlock:(void (^)(BOOL success,BOOL isCorrectResponse,NSError *error))completionBlock {
	NSMutableDictionary *queryParameters = [[NSMutableDictionary alloc] initWithCapacity:2];
	if (questionID != nil) {
		[queryParameters setValue:questionID forKey:@"id"];
	}
	if (answer != nil) {
		[queryParameters setValue:answer forKey:@"answer"];
	}
	NSMutableDictionary *processedQueryParams = [self addCredentialsToParameters:queryParameters];
	
	[[[self class] sharedClient] postPath:@"api/v1/submitFeatureCheckinQuestionAnswer.php"
							   parameters:processedQueryParams
								  success:^(AFHTTPRequestOperation *operation, id responseObject) {
									  if ([MCAPIHelper isAPIErrorResponse:responseObject]) {
										  completionBlock(NO,NO,nil);
									  }else {
										  RXMLElement *resultXML = [RXMLElement elementFromXMLData:responseObject];
										  BOOL responseWasCorrect = [[resultXML child:@"result"] attribute:@"success"].boolValue;
										  completionBlock(YES,responseWasCorrect,nil);
									  }
								  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
									  completionBlock(NO,NO,error);
								  }];

}


#pragma mark - private methods

- (void)postContentToPath:(NSString *)path withPhoto:(UIImage *)photo queryParameters:(NSMutableDictionary *)queryParameters completionBlock:(void (^)(BOOL, NSError *))completionBlock {
	NSMutableDictionary *processedQueryParams = [self addCredentialsToParameters:queryParameters];
    NSURLRequest *postRequest = [self multipartFormRequestWithMethod:@"POST"
                                                                                      path:path
                                                                                parameters:processedQueryParams
                                                                 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
																	 if (photo != nil) {
																		 NSData *imageData = UIImageJPEGRepresentation(photo,DEFAULT_IMAGE_COMPRESSION);
																		 DLog(@"about to upload a %u bytes image",imageData.length);
																		 [formData appendPartWithFileData:imageData
																									 name:@"photo"
																								 fileName:@"photo.jpg"
																								 mimeType:@"image/jpeg"];
																	 }
                                                                 }];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:postRequest];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *reqOperation, id responseObject) {

		if ([MCAPIHelper isAPIErrorResponse:responseObject]) {
			completionBlock(NO,nil);
		}else {
            completionBlock(YES, nil);
        }
    } failure:^(AFHTTPRequestOperation *reqOperation, NSError *error) {
        completionBlock(NO, error);
    }];

    [self enqueueHTTPRequestOperation:operation];
}

-(NSURL*)URLForPath:(NSString*)path {
	NSString *urlString = [NSString stringWithFormat:@"%@%@",kAFCityOutdoorsAPIBaseURLString,path];
	NSURL *theURL = [NSURL URLWithString:urlString];
	return theURL;
}

-(NSMutableDictionary*)addCredentialsToParameters:(NSMutableDictionary*)queryParams {
	if ([_credentials isLoggedIn]) {
		if ([_credentials authToken] != nil) {
			[queryParams setValue:[_credentials authToken] forKey:@"userToken"];
		}
		if ([_credentials userID] != nil) {
			[queryParams setValue:[_credentials userID] forKey:@"userID"];
		}
	}
	return queryParams;
}

- (void)userLoggedOut {
	MCCredentialStore *credentials = [[MCCredentialStore alloc] init];
	[credentials clearSavedCredentials];
}

@end
