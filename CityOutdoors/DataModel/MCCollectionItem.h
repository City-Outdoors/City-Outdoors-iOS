#import "_MCCollectionItem.h"

@class MCFeatureItem;
@interface MCCollectionItem : _MCCollectionItem {}

+ (MCCollectionItem *)collectionItemWithId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc;
- (MCFeatureItem*)featureItem;
+ (MCCollectionItem *)collectionItemWithCollectionId:(NSInteger)collectionId
										andFeatureID:(NSInteger)featureId
						   usingManagedObjectContext:(NSManagedObjectContext *)moc;
@end
