// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCFeature.h instead.

#import <CoreData/CoreData.h>


extern const struct MCFeatureAttributes {
	__unsafe_unretained NSString *featureID;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *shareURL;
	__unsafe_unretained NSString *title;
} MCFeatureAttributes;

extern const struct MCFeatureRelationships {
	__unsafe_unretained NSString *childItems;
	__unsafe_unretained NSString *contents;
	__unsafe_unretained NSString *featureItems;
	__unsafe_unretained NSString *question;
} MCFeatureRelationships;

extern const struct MCFeatureFetchedProperties {
} MCFeatureFetchedProperties;

@class MCCollectionItem;
@class MCContent;
@class MCFeatureItem;
@class MCQuestion;







@interface MCFeatureID : NSManagedObjectID {}
@end

@interface _MCFeature : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MCFeatureID*)objectID;




@property (nonatomic, strong) NSNumber* featureID;


@property int64_t featureIDValue;
- (int64_t)featureIDValue;
- (void)setFeatureIDValue:(int64_t)value_;

//- (BOOL)validateFeatureID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* latitude;


@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* longitude;


@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* shareURL;


//- (BOOL)validateShareURL:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* childItems;

- (NSMutableSet*)childItemsSet;




@property (nonatomic, strong) NSSet* contents;

- (NSMutableSet*)contentsSet;




@property (nonatomic, strong) NSSet* featureItems;

- (NSMutableSet*)featureItemsSet;




@property (nonatomic, strong) NSSet* question;

- (NSMutableSet*)questionSet;





@end

@interface _MCFeature (CoreDataGeneratedAccessors)

- (void)addChildItems:(NSSet*)value_;
- (void)removeChildItems:(NSSet*)value_;
- (void)addChildItemsObject:(MCCollectionItem*)value_;
- (void)removeChildItemsObject:(MCCollectionItem*)value_;

- (void)addContents:(NSSet*)value_;
- (void)removeContents:(NSSet*)value_;
- (void)addContentsObject:(MCContent*)value_;
- (void)removeContentsObject:(MCContent*)value_;

- (void)addFeatureItems:(NSSet*)value_;
- (void)removeFeatureItems:(NSSet*)value_;
- (void)addFeatureItemsObject:(MCFeatureItem*)value_;
- (void)removeFeatureItemsObject:(MCFeatureItem*)value_;

- (void)addQuestion:(NSSet*)value_;
- (void)removeQuestion:(NSSet*)value_;
- (void)addQuestionObject:(MCQuestion*)value_;
- (void)removeQuestionObject:(MCQuestion*)value_;

@end

@interface _MCFeature (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveFeatureID;
- (void)setPrimitiveFeatureID:(NSNumber*)value;

- (int64_t)primitiveFeatureIDValue;
- (void)setPrimitiveFeatureIDValue:(int64_t)value_;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;




- (NSString*)primitiveShareURL;
- (void)setPrimitiveShareURL:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveChildItems;
- (void)setPrimitiveChildItems:(NSMutableSet*)value;



- (NSMutableSet*)primitiveContents;
- (void)setPrimitiveContents:(NSMutableSet*)value;



- (NSMutableSet*)primitiveFeatureItems;
- (void)setPrimitiveFeatureItems:(NSMutableSet*)value;



- (NSMutableSet*)primitiveQuestion;
- (void)setPrimitiveQuestion:(NSMutableSet*)value;


@end
