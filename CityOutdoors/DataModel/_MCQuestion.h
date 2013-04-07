// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCQuestion.h instead.

#import <CoreData/CoreData.h>


extern const struct MCQuestionAttributes {
	__unsafe_unretained NSString *hasAnswered;
	__unsafe_unretained NSString *question;
	__unsafe_unretained NSString *questionID;
	__unsafe_unretained NSString *type;
} MCQuestionAttributes;

extern const struct MCQuestionRelationships {
	__unsafe_unretained NSString *feature;
} MCQuestionRelationships;

extern const struct MCQuestionFetchedProperties {
} MCQuestionFetchedProperties;

@class MCFeature;






@interface MCQuestionID : NSManagedObjectID {}
@end

@interface _MCQuestion : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MCQuestionID*)objectID;




@property (nonatomic, strong) NSNumber* hasAnswered;


@property BOOL hasAnsweredValue;
- (BOOL)hasAnsweredValue;
- (void)setHasAnsweredValue:(BOOL)value_;

//- (BOOL)validateHasAnswered:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* question;


//- (BOOL)validateQuestion:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* questionID;


@property int64_t questionIDValue;
- (int64_t)questionIDValue;
- (void)setQuestionIDValue:(int64_t)value_;

//- (BOOL)validateQuestionID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* type;


//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MCFeature* feature;

//- (BOOL)validateFeature:(id*)value_ error:(NSError**)error_;





@end

@interface _MCQuestion (CoreDataGeneratedAccessors)

@end

@interface _MCQuestion (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveHasAnswered;
- (void)setPrimitiveHasAnswered:(NSNumber*)value;

- (BOOL)primitiveHasAnsweredValue;
- (void)setPrimitiveHasAnsweredValue:(BOOL)value_;




- (NSString*)primitiveQuestion;
- (void)setPrimitiveQuestion:(NSString*)value;




- (NSNumber*)primitiveQuestionID;
- (void)setPrimitiveQuestionID:(NSNumber*)value;

- (int64_t)primitiveQuestionIDValue;
- (void)setPrimitiveQuestionIDValue:(int64_t)value_;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;





- (MCFeature*)primitiveFeature;
- (void)setPrimitiveFeature:(MCFeature*)value;


@end
