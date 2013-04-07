//
//  MCMenuViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCMenuViewController.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "MCAlertHelper.h"
#import "MCProfileViewController.h"
#import "MCCredentialStore.h"
#import "MCFavouritesViewController.h"
#import "MCCityOutdoorsAPIClient.h"
#import "MCAPIHelper.h"
#import "MCStyling.h"

@interface MCMenuViewController ()
-(void)showMailComposer:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *underMenuImageView;
@property (strong,nonatomic) MCCredentialStore *credentials;
@end

@implementation MCMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	[self styleView];
	self.title = nil;
	UILabel *menuTitleLabel = [[UILabel alloc] init];
	menuTitleLabel.frame = CGRectMake(0, 0, 80, 40);
	menuTitleLabel.backgroundColor = [UIColor clearColor];
	menuTitleLabel.textColor = [MCStyling greenTextColor];
	menuTitleLabel.text = @" Menu";
	menuTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
	UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuTitleLabel];
	self.navigationItem.leftBarButtonItem = menuItem;
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(userLoggedOut)
												 name:USER_LOGGED_OUT_NOTIFICATION
											   object:nil];

	_credentials = [[MCCredentialStore alloc] init];
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)styleView {
	_underMenuImageView.image = [MCStyling underMenuImage];
}
#pragma mark - Button actions

-(IBAction)showMapScreen:(id)sender {
	UIStoryboard *parkScreensStoryboard = [UIStoryboard storyboardWithName:@"MCParkScreens" bundle:nil];
	UIViewController *mapViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCParkMapViewController"];
	
	self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:mapViewController];
	
}


-(IBAction)showParksScreen:(id)sender {
	UIStoryboard *parkScreensStoryboard = [UIStoryboard storyboardWithName:@"MCParkScreens" bundle:nil];
	UIViewController *parkListViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCParkListViewController"];
	
	self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:parkListViewController];

}

-(IBAction)showParkFeaturesScreen:(id)sender {
	UIStoryboard *parkScreensStoryboard = [UIStoryboard storyboardWithName:@"MCParkScreens" bundle:nil];
	UIViewController *parkFeatureListViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCParkFeatureListViewController"];
	
	self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:parkFeatureListViewController];
}

-(IBAction)showFavouritesScreen:(id)sender {
	UIStoryboard *favouritesStoryboard = [UIStoryboard storyboardWithName:@"Favourites" bundle:nil];
	MCFavouritesViewController *favFeaturesVC = [favouritesStoryboard instantiateInitialViewController];
	favFeaturesVC.title = @"Favourites";
	self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:favFeaturesVC];
	
}

-(void)showMailComposer:(id)sender {
	if ([MFMailComposeViewController canSendMail]) {
		
		MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
		mailViewController.mailComposeDelegate = self;
		[mailViewController setSubject:@"City Outdoors iOS app"];
#warning Update the Contact Us email address
		[mailViewController setToRecipients:@[@"cityOutdoors@yolocode.com"]];
		
		[self presentModalViewController:mailViewController animated:YES];
	} else {
		DLog(@"Device is unable to send email in its current state.");
	}
}

-(void)showAccountPage:(id)sender {
	UIStoryboard *profileStoryboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
	UIViewController *accountViewController = [profileStoryboard instantiateInitialViewController];
	
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:accountViewController];
	
	[self presentModalViewController:nav animated:YES];
}

-(void)logout {
	[_credentials clearSavedCredentials];
}

#pragma mark -  MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissModalViewControllerAnimated:YES];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int rows = 5;
	if ([MFMailComposeViewController canSendMail]) {
		rows++;
	}
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCMenuCell"];
	cell.contentView.backgroundColor = [MCStyling greenTextColor];
	UIView *bgColorView = [[UIView alloc] init];
	[bgColorView setBackgroundColor:[UIColor colorWithRed:223/255.0 green:116/255.0 blue:45/255.0 alpha:1]];
	[cell setSelectedBackgroundView:bgColorView];
	BOOL isLoggedIn = [_credentials isLoggedIn];
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"Map";
			break;
		case 1:
			cell.textLabel.text = @"Parks";
			break;
		case 2:
			cell.textLabel.text = @"Park Features";
			break;
		case 3:
			cell.textLabel.text = @"Favourites";
			break;
		case 4:
			cell.textLabel.text = isLoggedIn ? @"Log out" : @"Log in";
			break;
		case 5:
			cell.textLabel.text = @"Contact us";
			break;
		default:
			break;
	}
	return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOOL isLoggedIn = [_credentials isLoggedIn];
	switch (indexPath.row) {
		case 0:
			[self showMapScreen:nil];
			break;
		case 1:
			[self showParksScreen:nil];
			break;
		case 2:
			[self showParkFeaturesScreen:nil];
			break;
		case 3:
			[self showFavouritesScreen:nil];
			break;
		case 4:
			isLoggedIn ? [self logout] : [self showAccountPage:nil];
			break;
		case 5:
			[self showMailComposer:nil];
			break;

		default:
			[MCAlertHelper featureNotImplementedYet];
			break;
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self.tableView reloadData];
}

#pragma mark - private methods 

-(void)userLoggedOut {
	dispatch_async(dispatch_get_main_queue(), ^{
		DLog(@"Reloading menu tableView");
		[self.tableView reloadData];
	});
}

- (void)viewDidUnload {
	[self setUnderMenuImageView:nil];
	[super viewDidUnload];
}
@end
