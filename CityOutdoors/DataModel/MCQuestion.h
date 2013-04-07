#import "_MCQuestion.h"

@interface MCQuestion : _MCQuestion {}
+ (MCQuestion *)questionWithId:(NSInteger)questionID usingManagedObjectContext:(NSManagedObjectContext *)moc;
@end
