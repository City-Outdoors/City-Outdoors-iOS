//
//  MCFeatureDetailViewController.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 10/11/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCFeatureDetailViewController.h"
#import "MCCollectionItem.h"
#import "MCFeature.h"
#import "MCFeatureItem.h"
#import "MCFeatureField.h"
#import "MCDataUpdater.h"
#import "MBProgressHUD.h"
#import "MCFeatureFieldView.h"
#import "MCAlertHelper.h"
#import "MCAppDataModel.h"
#import "MCContent.h"
#import "UIImageView+AFNetworking.h"
#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"
#import "MCParkMapViewController.h"
#import "MCAddCommentViewController.h"
#import "MCChildFeaturesViewController.h"
#import "SHK.h"
#import "MCAddReportViewController.h"
#import "MCStyling.h"
#import "MCCityOutdoorsAPIClient.h"
#import "MCCredentialStore.h"
#import "MCQuestion.h"
#import "MCQuestionView.h"

#define RECYCLABLE_VIEW_TAG 8008135

@interface MCFeatureDetailViewController ()
@property MBProgressHUD *hud;
@property (strong,nonatomic) NSMutableArray *photosDataSource;
@property (strong,nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong,nonatomic) NSMutableArray *photoCommentIDs;
@property (strong,nonatomic) IBOutlet UIBarButtonItem *favouriteButton;
@property CGRect originalContainerScrollViewFrame;
@end

@implementation MCFeatureDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	[self resetNavigationBackButtonTextForNextPushedViewController];
	[self configureButtons];
	/* Create photo browser */
	self.photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
	[self updateFeatureDetails];
	[self addSharingNavigationButton];

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self registerForNotifications];
	[self changeFavouriteButtonEnabledState];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidUnload {
	[self setContainerScrollView:nil];
	[self setFeatureImageView:nil];
	[self setShowOnMapButton:nil];
	[self setShowPhotoBrowserButton:nil];
	[self setDirectionsButton:nil];
	[self setChildFeaturesButton:nil];
	[super viewDidUnload];
}
#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photosDataSource.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photosDataSource.count){
        return [_photosDataSource objectAtIndex:index];
	}
    return nil;
}

#pragma mark - button actions

-(IBAction)showOnMap:(id)sender {
	UIStoryboard *parkScreensStoryboard = [UIStoryboard storyboardWithName:@"MCParkScreens" bundle:nil];
	MCParkMapViewController *mapViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCParkMapViewController"];
	DLog(@"To show featureID %@",_collectionItem.collectionItemID.stringValue);
	mapViewController.collectionItemIDToShow = _collectionItem.collectionItemID;
	self.sidePanelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:mapViewController];
}

-(IBAction)checkIn:(id)sender {
	[MCAlertHelper featureNotImplementedYet];
}

-(IBAction)comment:(id)sender {
	UIStoryboard *addCommentStoryboard = [UIStoryboard storyboardWithName:@"AddComment" bundle:nil];
	MCAddCommentViewController *addCommentVC = [addCommentStoryboard instantiateInitialViewController];
	addCommentVC.title = self.title;
	addCommentVC.featureID = _collectionItem.feature.featureID;
	[self.navigationController pushViewController:addCommentVC animated:YES];
}

-(IBAction)favouriteFeature:(id)sender {
	[self showHUDWithMessage:@"Adding to favourites"];
	[[MCCityOutdoorsAPIClient sharedClient] favouriteFeatureWithID:_collectionItem.feature.featureID
														completionBlock:^(BOOL success, NSError *error) {
															if (success) {
																[self hideHUDWithMessage:@"Favourite added."
																			  afterDelay:1];
															}else {
																[self hideHUDWithMessage:@"Could not add favourite."
																			  afterDelay:3];

															}
														}];
	
}

-(IBAction)reportProblem:(id)sender {
	UIStoryboard *addReportStoryboard = [UIStoryboard storyboardWithName:@"AddReport" bundle:nil];
	MCAddReportViewController *addReportVC = [addReportStoryboard instantiateInitialViewController];
	addReportVC.title = self.title;
	addReportVC.featureID = _collectionItem.feature.featureID;
	[self.navigationController pushViewController:addReportVC animated:YES];}

-(void)showPhotoBrowser:(id)sender {
	// Modal
	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
	nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	[nc.navigationBar setTitleTextAttributes:nil];
	[self presentModalViewController:nc animated:YES];
}

-(void)showDirections:(id)sender {
	CGFloat latitude = _collectionItem.feature.latitude.floatValue;
	CGFloat longitude = _collectionItem.feature.longitude.floatValue;
	Class mapItemClass = [MKMapItem class];
	if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]){
		/* if iOS6 Create an MKMapItem to pass to the Maps app */
		CLLocationCoordinate2D coordinate =
		CLLocationCoordinate2DMake(latitude, longitude);
		MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate
													   addressDictionary:nil];
		MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
		[mapItem setName:_collectionItem.title];
		NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
		[launchOptions setObject:MKLaunchOptionsDirectionsModeWalking forKey:MKLaunchOptionsDirectionsModeKey];
		/* Pass the map item to the Maps app */
		[mapItem openInMapsWithLaunchOptions:launchOptions];
	}else {
		
		NSString *mapsURLString = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%1.6f,%1.6f&saddr=Current+Location",
										 latitude, longitude];
		NSString *escapedMapsURLString = [mapsURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		DLog(@"maps URL %@",escapedMapsURLString);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:escapedMapsURLString]];
	}
}

-(IBAction)showListOfChildFeatures:(id)sender {
	UIStoryboard *childFeaturesStoryboard = [UIStoryboard storyboardWithName:@"ChildFeatures" bundle:nil];
	MCChildFeaturesViewController *childFeaturesVC = [childFeaturesStoryboard instantiateInitialViewController];
	childFeaturesVC.parentCollectionItem = _collectionItem;
	childFeaturesVC.title = @"Related features";
	[self.navigationController pushViewController:childFeaturesVC animated:YES];

}

-(IBAction)shareFeature:(id)sender {
	DLog(@"Share %@ with url %@",_collectionItem.title,_collectionItem.feature.shareURL);
	NSURL *urlToShare = [NSURL URLWithString:_collectionItem.feature.shareURL];
	NSString *titleToShare = [NSString stringWithFormat:@"Check out %@",_collectionItem.title];
	SHKItem *item = [SHKItem URL:urlToShare
						   title:titleToShare];
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [SHK setRootViewController:self];
	[actionSheet showInView:self.view];
}

#pragma mark - MCContentImageInteractionProtocol

-(void)showImageForContentWithID:(NSNumber*)commentID {
	NSUInteger commentPhotoIndex = [_photoCommentIDs indexOfObject:commentID];
	[self.photoBrowser setInitialPageIndex:commentPhotoIndex];
	[self showPhotoBrowser:nil];
}

#pragma mark - private methods

-(void)resetNavigationBackButtonTextForNextPushedViewController {
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle:@"Back"
								   style:UIBarButtonItemStyleBordered
								   target:nil action:nil];
	[self.navigationItem setBackBarButtonItem:backButton];
}
-(NSManagedObjectContext*)context {
	if (_managedContext == nil){
		_managedContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		_managedContext.persistentStoreCoordinator = [[MCAppDataModel sharedDataModel] persistentStoreCoordinator];
		[_managedContext setMergePolicy:NSOverwriteMergePolicy];
	}
	return _managedContext;
}

- (void)showHUDWithMessage:(NSString*)message {
    if (!_hud) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    
    [_hud setMode:MBProgressHUDModeIndeterminate];
    [_hud setLabelText:message];
    [self.view addSubview:_hud];
	[_hud show:YES];
}

-(void)hideHUDWithMessage:(NSString*)message afterDelay:(NSTimeInterval)delay {
	[_hud setLabelText:message];
	[_hud hide:YES afterDelay:delay];

}
-(void)updateFeatureDetails {
	[self showHUDWithMessage:@"Loading details..."];

	NSNumber *featureID = _collectionItem.feature.featureID;
	[MCDataUpdater updateFeatureWithID:featureID
			 usingManagedObjectContext:[self context]
					   completionBlock:^(BOOL success, NSError *error) {
						   dispatch_async(dispatch_get_main_queue(), ^{
							   if (success) {
								   [self hideHUDWithMessage:nil afterDelay:0];
							   }else {
								   [self hideHUDWithMessage:@"Could not load the details" afterDelay:3];
							   }
							   [self populateUIStrings];
							   [self setupPhotoBrowser];
							   [self changeShareButtonEnabledState];
						   });
					   }];
}

-(void)populateUIStrings {
	MCFeatureItem *featureItem = _collectionItem.featureItem;
	self.title = _collectionItem.title;
	NSSortDescriptor *byID = [NSSortDescriptor sortDescriptorWithKey:@"fieldID" ascending:YES];
	NSArray *fields = [featureItem.fieldsSet sortedArrayUsingDescriptors:@[byID]];
	int nextYCoordinate = CGRectGetMaxY(self.showOnMapButton.frame);
	nextYCoordinate = [self addChildFeaturesButton:nextYCoordinate];
	[self removeAllRecyclableViews];
	for (MCFeatureField *featureField in fields) {
		CGRect fieldViewFrame = CGRectMake(0, nextYCoordinate, self.view.bounds.size.width, 600);
		MCFeatureFieldView *fieldView = [[[NSBundle mainBundle] loadNibNamed:@"MCFeatureFieldView" owner:nil options:nil] objectAtIndex:0];
		fieldView.frame = fieldViewFrame;
		fieldView.tag = RECYCLABLE_VIEW_TAG;
		[fieldView populateFromFeatureField:featureField];
		if ([featureField.title isEqualToString:@"Title"]) {
			self.title = featureField.textValue;
			fieldView.titleLabel.text = @"";
		}
		[self.containerScrollView addSubview:fieldView];
		nextYCoordinate = CGRectGetMaxY(fieldView.frame);
	}
	nextYCoordinate = [self populateQuestionViewsStartingFromCoordinate:nextYCoordinate];
	nextYCoordinate = [self populateContentViewsStartingFromCoordinate:nextYCoordinate];
	MCContent *content = (MCContent*)[_collectionItem.feature.contentsSet anyObject];
	NSString *imageToPick = content.pictureNormalURL;
	[self.featureImageView setImageWithURL:[NSURL URLWithString:imageToPick] placeholderImage:[MCStyling imagePlaceholder]];
	self.containerScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, nextYCoordinate + 30);
	[self debugPrintChildFeatures];
	[self debugPrintCheckinQuestions];
}

-(void)debugPrintCheckinQuestions {
	MCFeature *currentFeature = _collectionItem.feature;
	DLog(@"Start Checkin Questions");
	for (MCQuestion *q in currentFeature.question) {
		DLog(@"Question with ID = %d type = %@ question: %@",q.questionID.integerValue,q.type,q.question);
	}
	DLog(@"End Checkin Questions");
}

-(void)debugPrintChildFeatures {
	MCFeature *currentFeature = _collectionItem.feature;
	DLog(@"Start Child Items");
	for (MCCollectionItem *childCollectionItem in currentFeature.childItems) {
		DLog(@"ChildCollectionItemID = %d",childCollectionItem.collectionItemID.integerValue);
	}
	DLog(@"End Child Items");
}

-(int)populateContentViewsStartingFromCoordinate:(int)nextYCoordinate {
	NSSet *contents = _collectionItem.feature.contents;
	BOOL __block oneOfTheCommentsHasABody = NO;
	[contents enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
		if ([(MCContent*)obj body].length > 0) {
			oneOfTheCommentsHasABody = YES;
			*stop = YES;
		}
	}];
	if (contents.count > 0 && oneOfTheCommentsHasABody) {
		CGRect commentsLabelFrame = CGRectMake(20, nextYCoordinate, self.view.bounds.size.width - 20, 30);
		UILabel *commentsLabel = [self headerLabelWithFrame:commentsLabelFrame andText:@"Comments"];
		[self.containerScrollView addSubview:commentsLabel];
		nextYCoordinate = CGRectGetMaxY(commentsLabel.frame);
	}
	for (MCContent *content in contents) {
		if (content.body.length > 0) {
			CGRect contentViewFrame = CGRectMake(0, nextYCoordinate, self.view.bounds.size.width, 100);
			MCContentView *contentView = [[[NSBundle mainBundle] loadNibNamed:@"MCContentView" owner:nil options:nil] objectAtIndex:0];
			contentView.frame = contentViewFrame;
			contentView.tag = RECYCLABLE_VIEW_TAG;
			contentView.delegate = self;
			[contentView populateFromContent:content];
			[self.containerScrollView addSubview:contentView];
			nextYCoordinate = CGRectGetMaxY(contentView.frame);
		}
	}
	return nextYCoordinate;
}

-(int)populateQuestionViewsStartingFromCoordinate:(int)nextYCoordinate {
	MCCredentialStore *credentials = [[MCCredentialStore alloc] init];
	if ([credentials isLoggedIn]) {
		NSSet *questions = _collectionItem.feature.question;
		if (questions.count > 0) {
			CGRect exploreLabelFrame = CGRectMake(20, nextYCoordinate, self.view.bounds.size.width - 20, 30);
			UILabel *exploreLabel = [self headerLabelWithFrame:exploreLabelFrame andText:@"Explore"];
			[self.containerScrollView addSubview:exploreLabel];
			nextYCoordinate = CGRectGetMaxY(exploreLabel.frame);
		}
		for (MCQuestion *question in questions) {
			CGRect questionViewFrame = CGRectMake(0, nextYCoordinate, self.view.bounds.size.width, 100);
			MCQuestionView *questionView = [[[NSBundle mainBundle] loadNibNamed:@"MCQuestionView" owner:nil options:nil] objectAtIndex:0];
			questionView.frame = questionViewFrame;
			questionView.tag = RECYCLABLE_VIEW_TAG;
			[questionView populateFromQuestion:question];
			[questionView setParentScrollView:_containerScrollView];
			[self.containerScrollView addSubview:questionView];
			nextYCoordinate = CGRectGetMaxY(questionView.frame);
		}
	}
	return nextYCoordinate;
}


-(int)addChildFeaturesButton:(int)nextYCoordinate {
	BOOL hasChildFeatures = _collectionItem.feature.childItems.count > 0;
	int nextYCoord = nextYCoordinate;
	_childFeaturesButton.hidden = !hasChildFeatures;
	if (hasChildFeatures) {
		nextYCoord = nextYCoord + _childFeaturesButton.frame.size.height;
	}
	return nextYCoord;
}

-(void)addSharingNavigationButton {
	UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
																				 target:self action:@selector(shareFeature:)];
	[self.navigationItem setRightBarButtonItem:shareButton animated:YES];
}

-(void)changeShareButtonEnabledState {
	BOOL shareURLAvailable = _collectionItem.feature.shareURL.length > 0;
	self.navigationItem.rightBarButtonItem.enabled = shareURLAvailable;
}

-(void)changeFavouriteButtonEnabledState {
	MCCredentialStore *credentials = [[MCCredentialStore alloc] init];
	_favouriteButton.enabled = [credentials isLoggedIn];

}

-(void)removeAllRecyclableViews {
	for (UIView *v in self.view.subviews){
		if (v.tag == RECYCLABLE_VIEW_TAG) {
			[v removeFromSuperview];
		}
	}
}

-(void)setupPhotoBrowser {
	NSMutableArray *photos = [[NSMutableArray alloc] init];
	_photoCommentIDs = [[NSMutableArray alloc] initWithCapacity:0];
    MWPhoto *photo;
	for (MCContent *content in _collectionItem.feature.contents) {
		if (content.hasPictureValue) {
			NSURL *imageURL =[NSURL URLWithString:content.pictureFullURL];
			[_photoCommentIDs addObject:content.contentID];
			photo = [MWPhoto photoWithURL:imageURL];
			[photos addObject:photo];
		}
	}
    self.photosDataSource = photos;
	self.showPhotoBrowserButton.enabled = self.photosDataSource.count > 0;
}

-(void)configureButtons {
	UIImage *buttonBackground = [[UIImage imageNamed:@"button_green_background.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:15];
	[MCStyling configureButton:self.showOnMapButton withBackgroundImage:buttonBackground];
	[MCStyling configureButton:self.directionsButton withBackgroundImage:buttonBackground];
	[MCStyling configureButton:self.childFeaturesButton withBackgroundImage:buttonBackground];
}
#pragma mark - Notification related methods

-(void)registerForNotifications {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide:)
												 name:UIKeyboardWillHideNotification
											   object:nil];

}

-(void)keyboardWillShow:(NSNotification*)notification {
	DLog(@"notification = %@",notification);
	NSDictionary *userInfo = [notification userInfo];
	CGRect keyboardBounds = [[userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
	CGFloat keyboardHeightMinusToolbar = keyboardBounds.size.height - 44;
	CGRect shrinkedScrollViewFrame = [self originalFrame];
	shrinkedScrollViewFrame.size.height = [self originalFrame].size.height - keyboardHeightMinusToolbar;
	[self animateContainerScrollViewToFrame:shrinkedScrollViewFrame];
}

-(void)keyboardWillHide:(NSNotification*)notification {
	DLog(@"notification = %@",notification);
	[self animateContainerScrollViewToFrame:[self originalFrame]];
}

-(void)animateContainerScrollViewToFrame:(CGRect)rect {
	DLog(@"Animating frame to %@",NSStringFromCGRect(rect));
	[UIView animateWithDuration:0.25 animations:^{
		self.containerScrollView.frame = rect;
	}];
	
}

-(CGRect)originalFrame {
	if ( CGRectEqualToRect(_originalContainerScrollViewFrame, CGRectZero) ||
		CGRectEqualToRect(_originalContainerScrollViewFrame, CGRectNull)) {
		_originalContainerScrollViewFrame = self.containerScrollView.frame;
		DLog(@"Original Frame = %@",NSStringFromCGRect(_originalContainerScrollViewFrame));
	}
	return _originalContainerScrollViewFrame;
}

-(UILabel*)headerLabelWithFrame:(CGRect)labelFrame andText:(NSString*)labelText {
	UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
	label.font = [MCStyling textFontOfSize:16];
	label.textColor = [MCStyling featureHeaderColor];
	label.text = labelText;
	label.tag = RECYCLABLE_VIEW_TAG;
	return label;
}

@end
