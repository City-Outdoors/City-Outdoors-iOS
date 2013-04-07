// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCFeatureField.h instead.

#import <CoreData/CoreData.h>


extern const struct MCFeatureFieldAttributes {
	__unsafe_unretained NSString *fieldID;
	__unsafe_unretained NSString *textValue;
	__unsafe_unretained NSString *title;
} MCFeatureFieldAttributes;

extern const struct MCFeatureFieldRelationships {
	__unsafe_unretained NSString *featureItem;
} MCFeatureFieldRelationships;

extern const struct MCFeatureFieldFetchedProperties {
} MCFeatureFieldFetchedProperties;

@class MCFeatureItem;





@interface MCFeatureFieldID : NSManagedObjectID {}
@end

@interface _MCFeatureField : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MCFeatureFieldID*)objectID;




@property (nonatomic, strong) NSNumber* fieldID;


@property int64_t fieldIDValue;
- (int64_t)fieldIDValue;
- (void)setFieldIDValue:(int64_t)value_;

//- (BOOL)validateFieldID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* textValue;


//- (BOOL)validateTextValue:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MCFeatureItem* featureItem;

//- (BOOL)validateFeatureItem:(id*)value_ error:(NSError**)error_;





@end

@interface _MCFeatureField (CoreDataGeneratedAccessors)

@end

@interface _MCFeatureField (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveFieldID;
- (void)setPrimitiveFieldID:(NSNumber*)value;

- (int64_t)primitiveFieldIDValue;
- (void)setPrimitiveFieldIDValue:(int64_t)value_;




- (NSString*)primitiveTextValue;
- (void)setPrimitiveTextValue:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (MCFeatureItem*)primitiveFeatureItem;
- (void)setPrimitiveFeatureItem:(MCFeatureItem*)value;


@end
