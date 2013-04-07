//
//  MCAppDataModel.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 29/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCAppDataModel.h"

@interface MCAppDataModel ()

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
- (NSString *)documentsDirectory;

@end

@implementation MCAppDataModel

@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainContext = _mainContext;

+ (id)sharedDataModel {
    static MCAppDataModel *__instance = nil;
	
	if (__instance == nil) {
        __instance = [[MCAppDataModel alloc] init];
    }
    
    return __instance;
}

- (NSString *)modelName {
    return @"CityOutdoors";
}

- (NSString *)pathToModel {
    return [[NSBundle mainBundle] pathForResource:[self modelName]
                                           ofType:@"momd"];
}

- (NSString *)storeFilename {
    return [[self modelName] stringByAppendingPathExtension:@"sqlite"];
}

- (NSString *)pathToLocalStore {
    return [[self documentsDirectory] stringByAppendingPathComponent:[self storeFilename]];
}

- (NSString *)documentsDirectory {
    NSString *documentsDirectory = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (NSManagedObjectContext *)mainContext {
    if (_mainContext == nil) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _mainContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
		[_mainContext setMergePolicy:NSOverwriteMergePolicy];
    }
    
    return _mainContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil) {
        NSURL *storeURL = [NSURL fileURLWithPath:[self pathToModel]];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:storeURL];
    }
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        DLog(@"SQLITE STORE PATH: %@", [self pathToLocalStore]);
        NSURL *storeURL = [NSURL fileURLWithPath:[self pathToLocalStore]];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]
                                             initWithManagedObjectModel:[self managedObjectModel]];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSError *e = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:options
                                       error:&e]) {
			DLog(@"failed to create persistent store: %@",e);
			
			BOOL succeeded = [[NSFileManager defaultManager] removeItemAtPath:[self pathToLocalStore] error:nil];
			if (succeeded) {
				DLog(@"2nd attempt to create persistent store");

				if (![psc addPersistentStoreWithType:NSSQLiteStoreType
									   configuration:nil
												 URL:storeURL
											 options:options
											   error:&e]) {
					DLog(@"failed 2nd attempt to create persistent store: %@",e);
				}
			}else if (![psc addPersistentStoreWithType:NSInMemoryStoreType
								   configuration:nil
											 URL:storeURL
										 options:options
										   error:&e]) {
				DLog(@"failed to create in memory persistent store: %@",e);				
			}
		}
        
        _persistentStoreCoordinator = psc;
    }
    
    return _persistentStoreCoordinator;
}

- (BOOL)resetDataModel {
	BOOL succeeded = NO;
	NSPersistentStoreCoordinator *storeCoordinator = [self persistentStoreCoordinator];
	for (NSPersistentStore *store in storeCoordinator.persistentStores) {
		NSError *error;
		NSURL *storeURL = store.URL;
		succeeded = [storeCoordinator removePersistentStore:store error:&error];
		if (!succeeded) {
			return succeeded;
		}
		succeeded = [[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error];
		if (!succeeded) {
			return succeeded;
		}
	}
	if (succeeded) {
		_persistentStoreCoordinator = nil;
		_managedObjectModel = nil;
		_mainContext = nil;
	}
	DLog(@"CoreData store was reset ? %@",succeeded ? @"YES" : @"NO");
	return succeeded;
}
@end
