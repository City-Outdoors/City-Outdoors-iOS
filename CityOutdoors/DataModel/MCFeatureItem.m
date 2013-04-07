#import "MCFeatureItem.h"

@implementation MCFeatureItem

// Custom logic goes here.
+ (MCFeatureItem *)featureItemWithId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCFeatureItem entityName]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"featureItemID = %d", serverId]];
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
