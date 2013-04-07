#import "MCCollectionItem.h"
#import "NSDictionary+ObjectForKeyOrNil.h"
#import "MCFeatureItem.h"
#import "MCFeature.h"

@interface MCCollectionItem ()
+ (MCCollectionItem*)collectionItemMatchingPredicate:(NSPredicate*)predicate
							withManagedObjectContext:(NSManagedObjectContext*)moc;
@end

@implementation MCCollectionItem

+ (MCCollectionItem *)collectionItemWithId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc {
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"collectionItemID = %d", serverId];
	return [self collectionItemMatchingPredicate:predicate
				 withManagedObjectContext:moc];
}

- (MCFeatureItem*)featureItem {
	for (MCFeatureItem *featureItem in self.feature.featureItems) {
		if ([featureItem.slug isEqualToString:self.slug]) {
			return featureItem;
		}
	}
	return nil;
}

+ (MCCollectionItem *)collectionItemWithCollectionId:(NSInteger)collectionId
										andFeatureID:(NSInteger)featureId
						   usingManagedObjectContext:(NSManagedObjectContext *)moc {
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"collection.collectionID = %d AND feature.featureID = %d", collectionId, featureId];
	return [self collectionItemMatchingPredicate:predicate
						withManagedObjectContext:moc];
}

#pragma mark - private 

+ (MCCollectionItem*)collectionItemMatchingPredicate:(NSPredicate*)predicate withManagedObjectContext:(NSManagedObjectContext*)moc {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCCollectionItem entityName]];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:fetchRequest error:&error];
    if (error) {
        DLog(@"ERROR: %@ %@", [error localizedDescription], [error userInfo]);
    }
    
    if ([results count] == 0) {
        return nil;
    }
    
    return [results objectAtIndex:0];
	
}

@end
