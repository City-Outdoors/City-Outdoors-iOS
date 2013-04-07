// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCContent.m instead.

#import "_MCContent.h"

const struct MCContentAttributes MCContentAttributes = {
	.body = @"body",
	.contentID = @"contentID",
	.hasPicture = @"hasPicture",
	.pictureFullURL = @"pictureFullURL",
	.pictureNormalURL = @"pictureNormalURL",
	.pictureThumbURL = @"pictureThumbURL",
};

const struct MCContentRelationships MCContentRelationships = {
	.feature = @"feature",
};

const struct MCContentFetchedProperties MCContentFetchedProperties = {
};

@implementation MCContentID
@end

@implementation _MCContent

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MCContent" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MCContent";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MCContent" inManagedObjectContext:moc_];
}

- (MCContentID*)objectID {
	return (MCContentID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"contentIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"contentID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"hasPictureValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasPicture"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic body;






@dynamic contentID;



- (int64_t)contentIDValue {
	NSNumber *result = [self contentID];
	return [result longLongValue];
}

- (void)setContentIDValue:(int64_t)value_ {
	[self setContentID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveContentIDValue {
	NSNumber *result = [self primitiveContentID];
	return [result longLongValue];
}

- (void)setPrimitiveContentIDValue:(int64_t)value_ {
	[self setPrimitiveContentID:[NSNumber numberWithLongLong:value_]];
}





@dynamic hasPicture;



- (BOOL)hasPictureValue {
	NSNumber *result = [self hasPicture];
	return [result boolValue];
}

- (void)setHasPictureValue:(BOOL)value_ {
	[self setHasPicture:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasPictureValue {
	NSNumber *result = [self primitiveHasPicture];
	return [result boolValue];
}

- (void)setPrimitiveHasPictureValue:(BOOL)value_ {
	[self setPrimitiveHasPicture:[NSNumber numberWithBool:value_]];
}





@dynamic pictureFullURL;






@dynamic pictureNormalURL;






@dynamic pictureThumbURL;






@dynamic feature;

	






@end
