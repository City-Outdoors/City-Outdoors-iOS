//
//  MCFavouritesViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 12/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCFavouritesViewController.h"
#import "MCDataUpdater.h"
#import "MCAppDataModel.h"
#import "MBProgressHUD.h"


@interface MCFavouritesViewController ()
-(NSArray*)sortedChildCollectionItems;
@property (strong,nonatomic) NSArray *childCollectionItems;
@property MBProgressHUD *hud;

@end

@implementation MCFavouritesViewController

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self reloadFavouritesFromWebService];
}

#pragma mark - private methods
-(void)reloadFavouritesFromWebService {
	[self setupAndShowHUDWithMessage:@"Loading favourites..."];
	[MCDataUpdater getFavouritesUsingManagedObjectContext:[[MCAppDataModel sharedDataModel] mainContext]
										  completionBlock:^(BOOL success, NSArray *favourites, NSError *error) {
											  _childCollectionItems = favourites;
											  dispatch_async(dispatch_get_main_queue(), ^{
												  [self.tableView reloadData];
												  if (success) {
													  [self cleanupAfterMessageSentSuccessfully];
												  }else {
													  if (error == nil && favourites == nil) {
														  [self hideHUDWithMessage:@"Log in to see favourites" afterDelay:5];
													  }else {
														  [self cleanupAfterMessageFailedToSend];
													  }
												  }
											  });
										  }];
}


-(NSArray*)sortedChildCollectionItems {
	return _childCollectionItems;

}

#pragma mark - private

-(void)setupAndShowHUDWithMessage:(NSString*)message {
	if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    
    [_hud setMode:MBProgressHUDModeIndeterminate];
    [_hud setLabelText:message];
	_hud.dimBackground = YES;
    [self.view addSubview:_hud];
	[_hud show:YES];
	
}

-(void)hideHUDWithMessage:(NSString*)message afterDelay:(NSTimeInterval)delay {
	[_hud setLabelText:message];
	[_hud hide:YES afterDelay:delay];	
}

-(void)cleanupAfterMessageSentSuccessfully {
	[self hideHUDWithMessage:@"Favourites loaded." afterDelay:0.5];
}

-(void)cleanupAfterMessageFailedToSend {
	[self hideHUDWithMessage:@"Couldn't load favourites." afterDelay:3];	
}


@end
