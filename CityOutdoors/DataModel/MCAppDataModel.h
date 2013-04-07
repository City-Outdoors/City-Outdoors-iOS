//
//  MCAppDataModel.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 29/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MCAppDataModel : NSObject

+ (id)sharedDataModel;

@property (nonatomic, readonly) NSManagedObjectContext *mainContext;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)modelName;
- (NSString *)pathToModel;
- (NSString *)storeFilename;
- (NSString *)pathToLocalStore;
- (BOOL)resetDataModel;
@end
