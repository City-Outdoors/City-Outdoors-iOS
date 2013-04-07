// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCFeatureItem.h instead.

#import <CoreData/CoreData.h>


extern const struct MCFeatureItemAttributes {
	__unsafe_unretained NSString *collectionID;
	__unsafe_unretained NSString *featureItemID;
	__unsafe_unretained NSString *slug;
} MCFeatureItemAttributes;

extern const struct MCFeatureItemRelationships {
	__unsafe_unretained NSString *feature;
	__unsafe_unretained NSString *fields;
} MCFeatureItemRelationships;

extern const struct MCFeatureItemFetchedProperties {
} MCFeatureItemFetchedProperties;

@class MCFeature;
@class MCFeatureField;





@interface MCFeatureItemID : NSManagedObjectID {}
@end

@interface _MCFeatureItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MCFeatureItemID*)objectID;




@property (nonatomic, strong) NSNumber* collectionID;


@property int64_t collectionIDValue;
- (int64_t)collectionIDValue;
- (void)setCollectionIDValue:(int64_t)value_;

//- (BOOL)validateCollectionID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* featureItemID;


@property int64_t featureItemIDValue;
- (int64_t)featureItemIDValue;
- (void)setFeatureItemIDValue:(int64_t)value_;

//- (BOOL)validateFeatureItemID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* slug;


//- (BOOL)validateSlug:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MCFeature* feature;

//- (BOOL)validateFeature:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* fields;

- (NSMutableSet*)fieldsSet;





@end

@interface _MCFeatureItem (CoreDataGeneratedAccessors)

- (void)addFields:(NSSet*)value_;
- (void)removeFields:(NSSet*)value_;
- (void)addFieldsObject:(MCFeatureField*)value_;
- (void)removeFieldsObject:(MCFeatureField*)value_;

@end

@interface _MCFeatureItem (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCollectionID;
- (void)setPrimitiveCollectionID:(NSNumber*)value;

- (int64_t)primitiveCollectionIDValue;
- (void)setPrimitiveCollectionIDValue:(int64_t)value_;




- (NSNumber*)primitiveFeatureItemID;
- (void)setPrimitiveFeatureItemID:(NSNumber*)value;

- (int64_t)primitiveFeatureItemIDValue;
- (void)setPrimitiveFeatureItemIDValue:(int64_t)value_;




- (NSString*)primitiveSlug;
- (void)setPrimitiveSlug:(NSString*)value;





- (MCFeature*)primitiveFeature;
- (void)setPrimitiveFeature:(MCFeature*)value;



- (NSMutableSet*)primitiveFields;
- (void)setPrimitiveFields:(NSMutableSet*)value;


@end
