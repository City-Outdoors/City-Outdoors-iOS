//
//  MCChildFeaturesViewController.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 21/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCCollectionItem;
@interface MCChildFeaturesViewController : UITableViewController
@property (strong,nonatomic) MCCollectionItem *parentCollectionItem;
@end
