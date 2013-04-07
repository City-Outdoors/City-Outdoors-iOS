// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to MCCollection.h instead.

#import <CoreData/CoreData.h>


extern const struct MCCollectionAttributes {
	__unsafe_unretained NSString *collectionDescription;
	__unsafe_unretained NSString *collectionID;
	__unsafe_unretained NSString *iconHeight;
	__unsafe_unretained NSString *iconURL;
	__unsafe_unretained NSString *iconWidth;
	__unsafe_unretained NSString *slug;
	__unsafe_unretained NSString *title;
} MCCollectionAttributes;

extern const struct MCCollectionRelationships {
	__unsafe_unretained NSString *items;
} MCCollectionRelationships;

extern const struct MCCollectionFetchedProperties {
} MCCollectionFetchedProperties;

@class MCCollectionItem;









@interface MCCollectionID : NSManagedObjectID {}
@end

@interface _MCCollection : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (MCCollectionID*)objectID;




@property (nonatomic, strong) NSString* collectionDescription;


//- (BOOL)validateCollectionDescription:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* collectionID;


@property int64_t collectionIDValue;
- (int64_t)collectionIDValue;
- (void)setCollectionIDValue:(int64_t)value_;

//- (BOOL)validateCollectionID:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* iconHeight;


@property int16_t iconHeightValue;
- (int16_t)iconHeightValue;
- (void)setIconHeightValue:(int16_t)value_;

//- (BOOL)validateIconHeight:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* iconURL;


//- (BOOL)validateIconURL:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* iconWidth;


@property int16_t iconWidthValue;
- (int16_t)iconWidthValue;
- (void)setIconWidthValue:(int16_t)value_;

//- (BOOL)validateIconWidth:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* slug;


//- (BOOL)validateSlug:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* title;


//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* items;

- (NSMutableSet*)itemsSet;





@end

@interface _MCCollection (CoreDataGeneratedAccessors)

- (void)addItems:(NSSet*)value_;
- (void)removeItems:(NSSet*)value_;
- (void)addItemsObject:(MCCollectionItem*)value_;
- (void)removeItemsObject:(MCCollectionItem*)value_;

@end

@interface _MCCollection (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCollectionDescription;
- (void)setPrimitiveCollectionDescription:(NSString*)value;




- (NSNumber*)primitiveCollectionID;
- (void)setPrimitiveCollectionID:(NSNumber*)value;

- (int64_t)primitiveCollectionIDValue;
- (void)setPrimitiveCollectionIDValue:(int64_t)value_;




- (NSNumber*)primitiveIconHeight;
- (void)setPrimitiveIconHeight:(NSNumber*)value;

- (int16_t)primitiveIconHeightValue;
- (void)setPrimitiveIconHeightValue:(int16_t)value_;




- (NSString*)primitiveIconURL;
- (void)setPrimitiveIconURL:(NSString*)value;




- (NSNumber*)primitiveIconWidth;
- (void)setPrimitiveIconWidth:(NSNumber*)value;

- (int16_t)primitiveIconWidthValue;
- (void)setPrimitiveIconWidthValue:(int16_t)value_;




- (NSString*)primitiveSlug;
- (void)setPrimitiveSlug:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveItems;
- (void)setPrimitiveItems:(NSMutableSet*)value;


@end
