#import "_MCFeature.h"
#import <CoreLocation/CoreLocation.h>

@interface MCFeature : _MCFeature {}

+ (MCFeature *)featureWithId:(NSInteger)serverId usingManagedObjectContext:(NSManagedObjectContext *)moc;
- (CLLocationCoordinate2D)coordinate;
@end
