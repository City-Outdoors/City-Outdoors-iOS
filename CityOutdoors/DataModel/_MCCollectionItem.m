// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCCollectionItem.m instead.

#import "_MCCollectionItem.h"

const struct MCCollectionItemAttributes MCCollectionItemAttributes = {
	.collectionItemID = @"collectionItemID",
	.slug = @"slug",
	.title = @"title",
};

const struct MCCollectionItemRelationships MCCollectionItemRelationships = {
	.collection = @"collection",
	.feature = @"feature",
};

const struct MCCollectionItemFetchedProperties MCCollectionItemFetchedProperties = {
};

@implementation MCCollectionItemID
@end

@implementation _MCCollectionItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MCCollectionItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MCCollectionItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MCCollectionItem" inManagedObjectContext:moc_];
}

- (MCCollectionItemID*)objectID {
	return (MCCollectionItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"collectionItemIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"collectionItemID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic collectionItemID;



- (int64_t)collectionItemIDValue {
	NSNumber *result = [self collectionItemID];
	return [result longLongValue];
}

- (void)setCollectionItemIDValue:(int64_t)value_ {
	[self setCollectionItemID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveCollectionItemIDValue {
	NSNumber *result = [self primitiveCollectionItemID];
	return [result longLongValue];
}

- (void)setPrimitiveCollectionItemIDValue:(int64_t)value_ {
	[self setPrimitiveCollectionItemID:[NSNumber numberWithLongLong:value_]];
}





@dynamic slug;






@dynamic title;






@dynamic collection;

	

@dynamic feature;

	






@end
