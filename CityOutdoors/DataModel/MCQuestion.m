#import "MCQuestion.h"

@implementation MCQuestion

+ (MCQuestion *)questionWithId:(NSInteger)questionID usingManagedObjectContext:(NSManagedObjectContext *)moc {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCQuestion entityName]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"questionID = %d", questionID]];
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
