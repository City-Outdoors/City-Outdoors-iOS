// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCFeature.m instead.

#import "_MCFeature.h"

const struct MCFeatureAttributes MCFeatureAttributes = {
	.featureID = @"featureID",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.shareURL = @"shareURL",
	.title = @"title",
};

const struct MCFeatureRelationships MCFeatureRelationships = {
	.childItems = @"childItems",
	.contents = @"contents",
	.featureItems = @"featureItems",
	.question = @"question",
};

const struct MCFeatureFetchedProperties MCFeatureFetchedProperties = {
};

@implementation MCFeatureID
@end

@implementation _MCFeature

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MCFeature" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MCFeature";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MCFeature" inManagedObjectContext:moc_];
}

- (MCFeatureID*)objectID {
	return (MCFeatureID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"featureIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"featureID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic featureID;



- (int64_t)featureIDValue {
	NSNumber *result = [self featureID];
	return [result longLongValue];
}

- (void)setFeatureIDValue:(int64_t)value_ {
	[self setFeatureID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveFeatureIDValue {
	NSNumber *result = [self primitiveFeatureID];
	return [result longLongValue];
}

- (void)setPrimitiveFeatureIDValue:(int64_t)value_ {
	[self setPrimitiveFeatureID:[NSNumber numberWithLongLong:value_]];
}





@dynamic latitude;



- (double)latitudeValue {
	NSNumber *result = [self latitude];
	return [result doubleValue];
}

- (void)setLatitudeValue:(double)value_ {
	[self setLatitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result doubleValue];
}

- (void)setPrimitiveLatitudeValue:(double)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithDouble:value_]];
}





@dynamic longitude;



- (double)longitudeValue {
	NSNumber *result = [self longitude];
	return [result doubleValue];
}

- (void)setLongitudeValue:(double)value_ {
	[self setLongitude:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result doubleValue];
}

- (void)setPrimitiveLongitudeValue:(double)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithDouble:value_]];
}





@dynamic shareURL;






@dynamic title;






@dynamic childItems;

	
- (NSMutableSet*)childItemsSet {
	[self willAccessValueForKey:@"childItems"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"childItems"];
  
	[self didAccessValueForKey:@"childItems"];
	return result;
}
	

@dynamic contents;

	
- (NSMutableSet*)contentsSet {
	[self willAccessValueForKey:@"contents"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"contents"];
  
	[self didAccessValueForKey:@"contents"];
	return result;
}
	

@dynamic featureItems;

	
- (NSMutableSet*)featureItemsSet {
	[self willAccessValueForKey:@"featureItems"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"featureItems"];
  
	[self didAccessValueForKey:@"featureItems"];
	return result;
}
	

@dynamic question;

	
- (NSMutableSet*)questionSet {
	[self willAccessValueForKey:@"question"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"question"];
  
	[self didAccessValueForKey:@"question"];
	return result;
}
	






@end
