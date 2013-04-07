// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCFeatureField.m instead.

#import "_MCFeatureField.h"

const struct MCFeatureFieldAttributes MCFeatureFieldAttributes = {
	.fieldID = @"fieldID",
	.textValue = @"textValue",
	.title = @"title",
};

const struct MCFeatureFieldRelationships MCFeatureFieldRelationships = {
	.featureItem = @"featureItem",
};

const struct MCFeatureFieldFetchedProperties MCFeatureFieldFetchedProperties = {
};

@implementation MCFeatureFieldID
@end

@implementation _MCFeatureField

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MCFeatureField" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MCFeatureField";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MCFeatureField" inManagedObjectContext:moc_];
}

- (MCFeatureFieldID*)objectID {
	return (MCFeatureFieldID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"fieldIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"fieldID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic fieldID;



- (int64_t)fieldIDValue {
	NSNumber *result = [self fieldID];
	return [result longLongValue];
}

- (void)setFieldIDValue:(int64_t)value_ {
	[self setFieldID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveFieldIDValue {
	NSNumber *result = [self primitiveFieldID];
	return [result longLongValue];
}

- (void)setPrimitiveFieldIDValue:(int64_t)value_ {
	[self setPrimitiveFieldID:[NSNumber numberWithLongLong:value_]];
}





@dynamic textValue;






@dynamic title;






@dynamic featureItem;

	






@end
