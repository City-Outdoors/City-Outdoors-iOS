//
//  MCChildFeaturesViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 21/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCChildFeaturesViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MCFeature.h"
#import "MCCollectionItem.h"
#import "MCCollection.h"
#import "MCFeatureDetailViewController.h"

@interface MCChildFeaturesViewController ()
-(NSArray*)sortedChildCollectionItems;
@property (strong,nonatomic) NSArray *childCollectionItems;
@end

@implementation MCChildFeaturesViewController

#pragma mark - private methods

-(NSArray*)sortedChildCollectionItems {
	if (_parentCollectionItem == nil) {
		return nil;
	}
	if (_childCollectionItems == nil) {
		_childCollectionItems = [_parentCollectionItem.feature.childItems allObjects];
	}
	
	return _childCollectionItems;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self sortedChildCollectionItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MCCollectionItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
	MCCollectionItem *item = [[self sortedChildCollectionItems] objectAtIndex:indexPath.row];
	
	cell.textLabel.text = item.title;
	NSURL *iconURL = [NSURL URLWithString:item.collection.iconURL];
    [cell.imageView setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"appIcon.png"]];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UIStoryboard *featureStoryboard = [UIStoryboard storyboardWithName:@"Feature" bundle:nil];
	MCFeatureDetailViewController *featureDetailVC = [featureStoryboard instantiateViewControllerWithIdentifier:@"MCFeatureDetailViewController"];
	
	MCCollectionItem *item = [[self sortedChildCollectionItems] objectAtIndex:indexPath.row];
	featureDetailVC.collectionItem = item;
	featureDetailVC.managedContext = item.managedObjectContext;
	[self.navigationController pushViewController:featureDetailVC animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
