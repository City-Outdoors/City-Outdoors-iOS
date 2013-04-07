// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCFeatureItem.m instead.

#import "_MCFeatureItem.h"

const struct MCFeatureItemAttributes MCFeatureItemAttributes = {
	.collectionID = @"collectionID",
	.featureItemID = @"featureItemID",
	.slug = @"slug",
};

const struct MCFeatureItemRelationships MCFeatureItemRelationships = {
	.feature = @"feature",
	.fields = @"fields",
};

const struct MCFeatureItemFetchedProperties MCFeatureItemFetchedProperties = {
};

@implementation MCFeatureItemID
@end

@implementation _MCFeatureItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MCFeatureItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MCFeatureItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MCFeatureItem" inManagedObjectContext:moc_];
}

- (MCFeatureItemID*)objectID {
	return (MCFeatureItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"collectionIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"collectionID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"featureItemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"featureItemID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic collectionID;



- (int64_t)collectionIDValue {
	NSNumber *result = [self collectionID];
	return [result longLongValue];
}

- (void)setCollectionIDValue:(int64_t)value_ {
	[self setCollectionID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveCollectionIDValue {
	NSNumber *result = [self primitiveCollectionID];
	return [result longLongValue];
}

- (void)setPrimitiveCollectionIDValue:(int64_t)value_ {
	[self setPrimitiveCollectionID:[NSNumber numberWithLongLong:value_]];
}





@dynamic featureItemID;



- (int64_t)featureItemIDValue {
	NSNumber *result = [self featureItemID];
	return [result longLongValue];
}

- (void)setFeatureItemIDValue:(int64_t)value_ {
	[self setFeatureItemID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveFeatureItemIDValue {
	NSNumber *result = [self primitiveFeatureItemID];
	return [result longLongValue];
}

- (void)setPrimitiveFeatureItemIDValue:(int64_t)value_ {
	[self setPrimitiveFeatureItemID:[NSNumber numberWithLongLong:value_]];
}





@dynamic slug;






@dynamic feature;

	

@dynamic fields;

	
- (NSMutableSet*)fieldsSet {
	[self willAccessValueForKey:@"fields"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"fields"];
  
	[self didAccessValueForKey:@"fields"];
	return result;
}
	






@end
