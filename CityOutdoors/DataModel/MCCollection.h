#import "_MCCollection.h"

@interface MCCollection : _MCCollection {}
+ (MCCollection *)collectionWithId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc;
@end
