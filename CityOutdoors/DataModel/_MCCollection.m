// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCCollection.m instead.

#import "_MCCollection.h"

const struct MCCollectionAttributes MCCollectionAttributes = {
	.collectionDescription = @"collectionDescription",
	.collectionID = @"collectionID",
	.iconHeight = @"iconHeight",
	.iconURL = @"iconURL",
	.iconWidth = @"iconWidth",
	.slug = @"slug",
	.title = @"title",
};

const struct MCCollectionRelationships MCCollectionRelationships = {
	.items = @"items",
};

const struct MCCollectionFetchedProperties MCCollectionFetchedProperties = {
};

@implementation MCCollectionID
@end

@implementation _MCCollection

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MCCollection" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MCCollection";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MCCollection" inManagedObjectContext:moc_];
}

- (MCCollectionID*)objectID {
	return (MCCollectionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"collectionIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"collectionID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"iconHeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"iconHeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"iconWidthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"iconWidth"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic collectionDescription;






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





@dynamic iconHeight;



- (int16_t)iconHeightValue {
	NSNumber *result = [self iconHeight];
	return [result shortValue];
}

- (void)setIconHeightValue:(int16_t)value_ {
	[self setIconHeight:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIconHeightValue {
	NSNumber *result = [self primitiveIconHeight];
	return [result shortValue];
}

- (void)setPrimitiveIconHeightValue:(int16_t)value_ {
	[self setPrimitiveIconHeight:[NSNumber numberWithShort:value_]];
}





@dynamic iconURL;






@dynamic iconWidth;



- (int16_t)iconWidthValue {
	NSNumber *result = [self iconWidth];
	return [result shortValue];
}

- (void)setIconWidthValue:(int16_t)value_ {
	[self setIconWidth:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIconWidthValue {
	NSNumber *result = [self primitiveIconWidth];
	return [result shortValue];
}

- (void)setPrimitiveIconWidthValue:(int16_t)value_ {
	[self setPrimitiveIconWidth:[NSNumber numberWithShort:value_]];
}





@dynamic slug;






@dynamic title;






@dynamic items;

	
- (NSMutableSet*)itemsSet {
	[self willAccessValueForKey:@"items"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"items"];
  
	[self didAccessValueForKey:@"items"];
	return result;
}
	






@end
