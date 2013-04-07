#import "_MCFeatureItem.h"

@interface MCFeatureItem : _MCFeatureItem {}

+ (MCFeatureItem *)featureItemWithId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc;

@end
