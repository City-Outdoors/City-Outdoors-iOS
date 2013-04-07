//
//  MCDataUpdater.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 30/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//


#import "MCDataUpdater.h"
#import "MCFeatureItem.h"
#import "MCCityOutdoorsAPIClient.h"
#import "MCCollection.h"
#import "MCCollectionItem.h"
#import "MCFeature.h"
#import "MCFeatureField.h"
#import "RXMLElement.h"
#import "AFNetworking.h"
#import "MCAppDataModel.h"
#import "MCContent.h"
#import "MCCredentialStore.h"
#import "MCQuestion.h"
#import "MCAPIHelper.h"

@interface MCDataUpdater ()
+(void)addCredentialDetailsToParameters:(NSMutableDictionary*)currentParams;
@end

@implementation MCDataUpdater

+(void)updateCollectionsRecursively {
	NSManagedObjectContext *collectionsMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	collectionsMOC.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
	[collectionsMOC setMergePolicy:NSOverwriteMergePolicy];
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
	[[self class] addCredentialDetailsToParameters:params];
	[[MCCityOutdoorsAPIClient sharedClient] getPath:@"api/v1/collections.php"
											  parameters:params
												 success:^(AFHTTPRequestOperation *operation, id response) {
													 if ([MCAPIHelper isAPIErrorResponse:response]) {
														 return;
													 }
													 RXMLElement *collectionsData = [RXMLElement elementFromXMLData:response];
													 NSArray *collectionContainer = [[collectionsData child:@"collections"] children:@"collection"];
													 DLog(@"%d collections found",[collectionContainer count]);
													 for (RXMLElement *collectionXML in collectionContainer) {
														 NSInteger collectionId = [collectionXML attribute:@"id"].integerValue;
														 NSManagedObjectContext *individualCollectionMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
														 individualCollectionMOC.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
														 [individualCollectionMOC setMergePolicy:NSOverwriteMergePolicy];

														 [MCDataUpdater updateCollectionWithID:@(collectionId) usingManagedObjectContext:individualCollectionMOC];
													 }
													 NSError *error = nil;
													 if ([collectionsMOC save:&error]) {
														 DLog(@"Saved Collections to CoreData");
													 } else {
														 DLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
													 }
													 
												 }
												 failure:^(AFHTTPRequestOperation *operation, NSError *error){
													 DLog(@"API Client request failed");
													 [collectionsMOC save:nil];
												 }];
	

}

+(void)updateCollectionsUsingManagedObjectContext:(NSManagedObjectContext *)moc {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
	[[self class] addCredentialDetailsToParameters:params];
	[[MCCityOutdoorsAPIClient sharedClient] getPath:@"api/v1/collections.php"
											  parameters:params
												 success:^(AFHTTPRequestOperation *operation, id response) {
													 if ([MCAPIHelper isAPIErrorResponse:response]) {
														 return;
													 }
													 RXMLElement *collectionsData = [RXMLElement elementFromXMLData:response];
													 NSArray *collectionContainer = [[collectionsData child:@"collections"] children:@"collection"];
													 DLog(@"%d collections found",[collectionContainer count]);
													 for (RXMLElement *collectionXML in collectionContainer) {
														 NSInteger collectionId = [collectionXML attribute:@"id"].integerValue;
														 [MCDataUpdater updateCollectionWithID:@(collectionId) usingManagedObjectContext:moc];
													 }
													 NSError *error = nil;
													 if ([moc save:&error]) {
														 DLog(@"Saved Collections to CoreData");
													 } else {
														 DLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
													 }

												 }
												 failure:^(AFHTTPRequestOperation *operation, NSError *error){
													 DLog(@"API Client request failed");
														[moc save:nil];
												 }];

}

+(void)updateCollectionWithID:(NSNumber*)collectionID
	usingManagedObjectContext:(NSManagedObjectContext *)moc{
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
	[params setValue:collectionID forKey:@"id"];
	[[self class] addCredentialDetailsToParameters:params];

	[[MCCityOutdoorsAPIClient sharedClient] getPath:@"api/v1/collection.php"
											  parameters:params
												 success:^(AFHTTPRequestOperation *operation, id response) {
													 DLog(@"Request %@",operation.request.URL.absoluteString);
													 if ([MCAPIHelper isAPIErrorResponse:response]) {
														 return;
													 }

													 RXMLElement *collectionsData = [RXMLElement elementFromXMLData:response];
													 RXMLElement *collectionXML = [collectionsData child:@"collection"];
													 MCCollection *collection = [MCCollection collectionWithId:collectionID.integerValue usingManagedObjectContext:moc];
													 if (collection == nil) {
														 collection = [MCCollection insertInManagedObjectContext:moc];
														 collection.collectionID = collectionID;
													 }
													 
													 collection.collectionDescription = [collectionXML child:@"description"].text;
													 collection.slug = [collectionXML attribute:@"slug"];
													 collection.title = [collectionXML child:@"title"].text;
													 RXMLElement *icon = [collectionXML child:@"icon"];
													 collection.iconHeight = @([icon attribute:@"height"].integerValue);
													 collection.iconWidth = @([icon attribute:@"width"].integerValue);
													 NSString *absoluteIconPath = [icon attribute:@"url"];
													 
													 if (absoluteIconPath.length > 0) {
														 collection.iconURL = absoluteIconPath;
													 }else {
														 /*This might return an absolute path but it is a relative path for now. */
														 collection.iconURL = [NSString stringWithFormat:@"%@://%@%@",
																			   operation.request.URL.scheme,operation.request.URL.host,icon.text];
													 }
													 NSArray *collectionItems = [[collectionXML child:@"items"] children:@"item"];
													 DLog(@"CollectionItem count = %d",collectionItems.count);
													 for (RXMLElement *collectionItemXML in collectionItems) {
														 NSInteger itemId = [collectionItemXML attribute:@"id"].integerValue;
														 BOOL isDeletedItem = [collectionItemXML attribute:@"deleted"].boolValue;
														 DLog(@"Collection %d Item %d is Deleted? %@",collectionID.integerValue,itemId,isDeletedItem? @"YES" : @"NO");
														 MCCollectionItem *item = [MCCollectionItem collectionItemWithId:itemId usingManagedObjectContext:moc];
														 if (isDeletedItem) {
															 if (item != nil) {
																 [moc deleteObject:item];
															 }
														 } else {
															 if (item == nil) {
																 item = [MCCollectionItem insertInManagedObjectContext:moc];
																 item.collectionItemID = @(itemId);
															 }
															 
															 item.slug = [collectionItemXML attribute:@"slug"];
															 item.title = [collectionItemXML child:@"title"].text;
															 item.collection = collection;
															 
															 RXMLElement *featureXML = [collectionItemXML child:@"feature"];
															 NSInteger featureID = [featureXML attribute:@"id"].integerValue;
															 MCFeature *feature = [MCFeature featureWithId:featureID
																				 usingManagedObjectContext:moc];
															 if (feature == nil) {
																 feature = [MCFeature insertInManagedObjectContext:moc];
																 feature.featureID = @(featureID);
															 }
															 NSString *featureTitle = [featureXML attribute:@"title"];
															 if (featureTitle != nil) {
																 feature.title = featureTitle;
															 }else {
																 feature.title = item.title;
															 }
															 feature.latitude = @([featureXML attribute:@"lat"].doubleValue);
															 feature.longitude = @([featureXML attribute:@"lng"].doubleValue);
															 item.feature = feature;
														 }
													 }
													 NSError *error = nil;
													 if ([moc save:&error]) {
														 DLog(@"saved all collectionItems from collection %d",collectionID.integerValue);
													 } else {
														 DLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
													 }

												 }
												 failure:^(AFHTTPRequestOperation *operation, NSError *error){
													 DLog(@"API Client request failed");
													 [moc save:nil];
												 }];

}

+(void)updateFeatureWithID:(NSNumber*)featureID
 usingManagedObjectContext:(NSManagedObjectContext *)moc{
	[[self class] updateFeatureWithID:featureID
			usingManagedObjectContext:moc
					  completionBlock:^(BOOL success, NSError *error) { }];
}

+(void)updateFeatureWithID:(NSNumber*)featureID
	usingManagedObjectContext:(NSManagedObjectContext *)moc
			  completionBlock:(void (^)(BOOL success, NSError *error))completionBlock {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
	[params setValue:@(0) forKey:@"showLinks"];
	[params setValue:featureID forKey:@"id"];
	[params setValue:@"mobileapp" forKey:@"fieldInContentArea"];
	[[self class] addCredentialDetailsToParameters:params];

	[[MCCityOutdoorsAPIClient sharedClient] getPath:@"api/v1/feature.php"
			parameters:params
			   success:^(AFHTTPRequestOperation *operation, id response) {
				   DLog(@"Request URL String %@",operation.request.URL.absoluteString);
				   if ([MCAPIHelper isAPIErrorResponse:response]) {
					   completionBlock(NO,nil);
					   return;
				   }
				   
				   RXMLElement *featureData = [RXMLElement elementFromXMLData:response];
				   RXMLElement *featureXML = [featureData child:@"feature"];
				   MCFeature *feature = [MCFeature featureWithId:featureID.integerValue usingManagedObjectContext:moc];
				   if (feature == nil) {
					   feature = [MCFeature insertInManagedObjectContext:moc];
					   feature.featureID = featureID;
				   }
				   
				   feature.title = [featureXML attribute:@"title"];
				   feature.latitude = @([featureXML attribute:@"lat"].doubleValue);
				   feature.longitude = @([featureXML attribute:@"lng"].doubleValue);
				   feature.shareURL = [featureXML attribute:@"shareURL"];
				   
				   NSArray *contents = [[featureXML child:@"contents"] children:@"content"];
				   [feature.contentsSet removeAllObjects];
				   for (RXMLElement *contentXML in contents) {
					   MCContent *content = [MCContent insertInManagedObjectContext:moc];
					   content.contentID = @([contentXML attribute:@"id"].integerValue);
					   content.hasPicture = @([contentXML attribute:@"hasPicture"].boolValue);
					   content.body = [contentXML child:@"body"].text;
					   content.pictureFullURL = [[contentXML child:@"picture"] attribute:@"fullURL"];
					   content.pictureNormalURL = [[contentXML child:@"picture"] attribute:@"normalURL"];
					   content.pictureThumbURL = [[contentXML child:@"picture"] attribute:@"thumbURL"];
					   [feature addContentsObject:content];
				   }
				   NSArray *featureItems = [[featureXML child:@"items"] children:@"item"];
				   for (RXMLElement *featureItemXML in featureItems) {
					   NSInteger featureItemID = [featureItemXML attribute:@"id"].integerValue;
					   MCFeatureItem *featureItem = [MCFeatureItem featureItemWithId:featureItemID
														   usingManagedObjectContext:moc];
					   if (featureItem == nil) {
						   featureItem = [MCFeatureItem insertInManagedObjectContext:moc];
						   featureItem.featureItemID = @(featureItemID);
					   }
					   featureItem.collectionID = @([featureItemXML attribute:@"collectionID"].integerValue);
					   featureItem.slug = [featureItemXML attribute:@"slug"];
					   featureItem.feature = feature;
					   [featureItem.fieldsSet removeAllObjects];
					   NSArray *fields = [[featureItemXML child:@"fields"] children:@"field"];
					   for (RXMLElement *fieldXML in fields) {
						   MCFeatureField *field = [MCFeatureField insertInManagedObjectContext:moc];
						   field.fieldID = @([fieldXML attribute:@"id"].integerValue);
						   field.title = [fieldXML attribute:@"title"];
						   field.textValue = [fieldXML child:@"valueText"].text;
						   if (field.textValue.length > 0) {
							   field.featureItem = featureItem;
							   [featureItem addFieldsObject:field];
						   }
					   }
				   }
				   NSArray *childItems = [[featureXML child:@"childItems"] children:@"item"];
				   [feature.childItemsSet removeAllObjects];
				   for (RXMLElement *childItemXML in childItems) {
					   NSInteger childCollectionItemID = [childItemXML attribute:@"id"].integerValue;
					   MCCollectionItem *childCollectionItem = [MCCollectionItem collectionItemWithId:childCollectionItemID
																	 usingManagedObjectContext:moc];
					   if (childCollectionItem == nil) {
						   childCollectionItem = [MCCollectionItem insertInManagedObjectContext:moc];
						   childCollectionItem.collectionItemID = @(childCollectionItemID);
					   }
					   [feature addChildItemsObject:childCollectionItem];
				   }
				   
				   NSArray *checkinQuestions = [[featureXML child:@"checkinQuestions"] children:@"checkinQuestion"];
				   [feature.questionSet removeAllObjects];
				   for (RXMLElement *checkinQuestionXML in checkinQuestions) {
					   NSInteger questionID = [checkinQuestionXML attribute:@"id"].integerValue;
					   MCQuestion *question = [MCQuestion questionWithId:questionID
											   usingManagedObjectContext:moc];
					   if (question == nil) {
						   question = [MCQuestion insertInManagedObjectContext:moc];
						   question.questionID = @(questionID);
					   }
					   question.type = [checkinQuestionXML attribute:@"type"];
					   question.question = [checkinQuestionXML attribute:@"question"];
					   question.hasAnswered = @([checkinQuestionXML attribute:@"hasAnswered"].boolValue);
					   [feature addQuestionObject:question];
				   }
				   
				   
				   NSError *error = nil;
				   if ([moc save:&error]) {
					   DLog(@"saved all details from feature %d",featureID.integerValue);
						completionBlock(YES,error);
				   } else {
					   completionBlock(NO,error);
					   DLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
				   }
				   
			   }
			   failure:^(AFHTTPRequestOperation *operation, NSError *error){
				   DLog(@"API Client request failed");
				   completionBlock(NO,error);
			   }];

}

+(void)getFavouritesUsingManagedObjectContext:(NSManagedObjectContext*)moc
							  completionBlock:(void (^)(BOOL success,NSArray *favourites, NSError *error))completionBlock {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
	[[self class] addCredentialDetailsToParameters:params];
	[[MCCityOutdoorsAPIClient sharedClient] getPath:@"api/v1/favourites.php"
											  parameters:params
												 success:^(AFHTTPRequestOperation *operation, id responseObject) {
													 DLog(@"Request URL String %@",operation.request.URL.absoluteString);
													 if ([MCAPIHelper isAPIErrorResponse:responseObject]) {
														 completionBlock(NO,nil,nil);
														 return;
													 }

													 NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
													 RXMLElement *xmlData = [[RXMLElement alloc] initFromXMLString:responseString encoding:NSUTF8StringEncoding];
													 RXMLElement *featuresXML = [xmlData child:@"features"];
													 NSArray *featureArray = [featuresXML children:@"feature"];
													 NSMutableArray *favouriteCollectionItems = [[NSMutableArray alloc] initWithCapacity:0];
													 for (RXMLElement *featureXML in featureArray) {
														 NSInteger featureID = [featureXML attribute:@"id"].integerValue;
														 NSArray *itemsXML = [[featureXML child:@"items"] children:@"item"];
														 RXMLElement *itemXML = [itemsXML lastObject];
														 NSInteger collectionID = [itemXML attribute:@"collectionID"].integerValue;
														 MCCollectionItem *collectionItem = [MCCollectionItem collectionItemWithCollectionId:collectionID
																																andFeatureID:featureID usingManagedObjectContext:moc];
														 if (collectionItem != nil) {
															 [favouriteCollectionItems addObject:collectionItem];
														 }
													 }
													 NSArray *favourites = [NSArray arrayWithArray:favouriteCollectionItems];
													 completionBlock(YES,favourites,nil);
													 
	 
												 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
													 completionBlock(NO,nil,error);
												 }];
}


#pragma mark - private 
+(void)addCredentialDetailsToParameters:(NSMutableDictionary*)currentParams {
	if (currentParams == nil) {
		return;
	}
	MCCredentialStore *credentials = [[MCCredentialStore alloc] init];
	if ([credentials isLoggedIn]) {
		if (credentials.authToken != nil) {
			[currentParams setValue:credentials.authToken forKey:@"userToken"];
		}
		if (credentials.userID != nil) {
			[currentParams setValue:credentials.userID forKey:@"userID"];
		}
	}
}

@end
