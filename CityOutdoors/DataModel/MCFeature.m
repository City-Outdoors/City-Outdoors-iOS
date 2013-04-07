#import "MCFeature.h"
#import "NSDictionary+ObjectForKeyOrNil.h"

@implementation MCFeature

+ (MCFeature *)featureWithId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc {
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[MCFeature entityName]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"featureID = %d", serverId]];
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

- (CLLocationCoordinate2D)coordinate {
	double lat = self.latitude.doubleValue;
	double lng = self.longitude.doubleValue;
	CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(lat, lng);
	return coord;
}

@end
