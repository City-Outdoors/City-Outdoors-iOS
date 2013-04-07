// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCContent.h instead.

#import <CoreData/CoreData.h>


extern const struct MCContentAttributes {
	__unsafe_unretained NSString *body;
	__unsafe_unretained NSString *contentID;
	__unsafe_unretained NSString *hasPicture;
	__unsafe_unretained NSString *pictureFullURL;
	__unsafe_unretained NSString *pictureNormalURL;
	__unsafe_unretained NSString *pictureThumbURL;
} MCContentAttributes;

extern const struct MCContentRelationships {
	__unsafe_unretained NSString *feature;
} MCContentRelationships;

extern const struct MCContentFetchedProperties {
} MCContentFetchedProperties;

@class MCFeature;








@interface MCContentID : NSManagedObjectID {}
@end

@interface _MCContent : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MCContentID*)objectID;




@property (nonatomic, strong) NSString* body;


//- (BOOL)validateBody:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* contentID;


@property int64_t contentIDValue;
- (int64_t)contentIDValue;
- (void)setContentIDValue:(int64_t)value_;

//- (BOOL)validateContentID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* hasPicture;


@property BOOL hasPictureValue;
- (BOOL)hasPictureValue;
- (void)setHasPictureValue:(BOOL)value_;

//- (BOOL)validateHasPicture:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* pictureFullURL;


//- (BOOL)validatePictureFullURL:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* pictureNormalURL;


//- (BOOL)validatePictureNormalURL:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* pictureThumbURL;


//- (BOOL)validatePictureThumbURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MCFeature* feature;

//- (BOOL)validateFeature:(id*)value_ error:(NSError**)error_;





@end

@interface _MCContent (CoreDataGeneratedAccessors)

@end

@interface _MCContent (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBody;
- (void)setPrimitiveBody:(NSString*)value;




- (NSNumber*)primitiveContentID;
- (void)setPrimitiveContentID:(NSNumber*)value;

- (int64_t)primitiveContentIDValue;
- (void)setPrimitiveContentIDValue:(int64_t)value_;




- (NSNumber*)primitiveHasPicture;
- (void)setPrimitiveHasPicture:(NSNumber*)value;

- (BOOL)primitiveHasPictureValue;
- (void)setPrimitiveHasPictureValue:(BOOL)value_;




- (NSString*)primitivePictureFullURL;
- (void)setPrimitivePictureFullURL:(NSString*)value;




- (NSString*)primitivePictureNormalURL;
- (void)setPrimitivePictureNormalURL:(NSString*)value;




- (NSString*)primitivePictureThumbURL;
- (void)setPrimitivePictureThumbURL:(NSString*)value;





- (MCFeature*)primitiveFeature;
- (void)setPrimitiveFeature:(MCFeature*)value;


@end
