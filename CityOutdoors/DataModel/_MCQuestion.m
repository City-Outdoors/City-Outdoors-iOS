// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCQuestion.m instead.

#import "_MCQuestion.h"

const struct MCQuestionAttributes MCQuestionAttributes = {
	.hasAnswered = @"hasAnswered",
	.question = @"question",
	.questionID = @"questionID",
	.type = @"type",
};

const struct MCQuestionRelationships MCQuestionRelationships = {
	.feature = @"feature",
};

const struct MCQuestionFetchedProperties MCQuestionFetchedProperties = {
};

@implementation MCQuestionID
@end

@implementation _MCQuestion

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MCQuestion" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MCQuestion";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MCQuestion" inManagedObjectContext:moc_];
}

- (MCQuestionID*)objectID {
	return (MCQuestionID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"hasAnsweredValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasAnswered"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"questionIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"questionID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic hasAnswered;



- (BOOL)hasAnsweredValue {
	NSNumber *result = [self hasAnswered];
	return [result boolValue];
}

- (void)setHasAnsweredValue:(BOOL)value_ {
	[self setHasAnswered:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasAnsweredValue {
	NSNumber *result = [self primitiveHasAnswered];
	return [result boolValue];
}

- (void)setPrimitiveHasAnsweredValue:(BOOL)value_ {
	[self setPrimitiveHasAnswered:[NSNumber numberWithBool:value_]];
}





@dynamic question;






@dynamic questionID;



- (int64_t)questionIDValue {
	NSNumber *result = [self questionID];
	return [result longLongValue];
}

- (void)setQuestionIDValue:(int64_t)value_ {
	[self setQuestionID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveQuestionIDValue {
	NSNumber *result = [self primitiveQuestionID];
	return [result longLongValue];
}

- (void)setPrimitiveQuestionIDValue:(int64_t)value_ {
	[self setPrimitiveQuestionID:[NSNumber numberWithLongLong:value_]];
}





@dynamic type;






@dynamic feature;

	






@end
