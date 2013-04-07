// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCCollectionItem.h instead.

#import <CoreData/CoreData.h>


extern const struct MCCollectionItemAttributes {
	__unsafe_unretained NSString *collectionItemID;
	__unsafe_unretained NSString *slug;
	__unsafe_unretained NSString *title;
} MCCollectionItemAttributes;

extern const struct MCCollectionItemRelationships {
	__unsafe_unretained NSString *collection;
	__unsafe_unretained NSString *feature;
} MCCollectionItemRelationships;

extern const struct MCCollectionItemFetchedProperties {
} MCCollectionItemFetchedProperties;

@class MCCollection;
@class MCFeature;





@interface MCCollectionItemID : NSManagedObjectID {}
@end

@interface _MCCollectionItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MCCollectionItemID*)objectID;




@property (nonatomic, strong) NSNumber* collectionItemID;


@property int64_t collectionItemIDValue;
- (int64_t)collectionItemIDValue;
- (void)setCollectionItemIDValue:(int64_t)value_;

//- (BOOL)validateCollectionItemID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* slug;


//- (BOOL)validateSlug:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) MCCollection* collection;

//- (BOOL)validateCollection:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) MCFeature* feature;

//- (BOOL)validateFeature:(id*)value_ error:(NSError**)error_;





@end

@interface _MCCollectionItem (CoreDataGeneratedAccessors)

@end

@interface _MCCollectionItem (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCollectionItemID;
- (void)setPrimitiveCollectionItemID:(NSNumber*)value;

- (int64_t)primitiveCollectionItemIDValue;
- (void)setPrimitiveCollectionItemIDValue:(int64_t)value_;




- (NSString*)primitiveSlug;
- (void)setPrimitiveSlug:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (MCCollection*)primitiveCollection;
- (void)setPrimitiveCollection:(MCCollection*)value;



- (MCFeature*)primitiveFeature;
- (void)setPrimitiveFeature:(MCFeature*)value;


@end
