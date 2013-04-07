#import "MCCollection.h"
#import "NSDictionary+ObjectForKeyOrNil.h"


@implementation MCCollection

+ (MCCollection *)collectionWithId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCCollection entityName]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"collectionID = %d", serverId]];
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
