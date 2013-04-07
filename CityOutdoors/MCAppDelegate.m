//
//  MCAppDelegate.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 17/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import "MCAppDelegate.h"
#import "JASidePanelController.h"
#import "MCAppDataModel.h"
#import "MCDataUpdater.h"
#import "MCMenuViewController.h"
#import "MCParkMapViewController.h"
#import "SHKConfiguration.h"
#import "MCCityOutdoorsSHKConfigurator.h"
#import "SHKFacebook.h"
#import "MCStyling.h"

@implementation MCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	[self configureShareKit];
	[MCStyling styleApplication];
	[self prepareCoreDataMigration];
	[MCDataUpdater updateCollectionsRecursively];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[JASidePanelController alloc] init];
    self.viewController.shouldDelegateAutorotateToVisiblePanel = YES;
	self.viewController.leftGapPercentage = .6;
	UIStoryboard *parkScreensStoryboard = [UIStoryboard storyboardWithName:@"MCParkScreens" bundle:nil];
	MCMenuViewController *menuViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCMenuViewController"];
    
	self.viewController.leftPanel = [[UINavigationController alloc] initWithRootViewController:menuViewController];
	MCParkMapViewController *mapViewController = [parkScreensStoryboard instantiateViewControllerWithIdentifier:@"MCParkMapViewController"];

	self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:mapViewController];
	
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    return YES;
}


-(void)prepareCoreDataMigration {
	if ([self shouldResetCoreData]) {
		[[MCAppDataModel sharedDataModel] resetDataModel];
	}
}

-(BOOL)shouldResetCoreData {
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	if (![[settings objectForKey:@"AppVersion"] isEqualToString:@"1.0"]) {
		[settings setObject:@"1.0" forKey:@"AppVersion"];
		[settings synchronize];
		return YES;
	}
	return NO;
}

-(void)configureShareKit {
	DefaultSHKConfigurator *configurator = [[MCCityOutdoorsSHKConfigurator alloc] init];
	[SHKConfiguration sharedInstanceWithConfigurator:configurator];

}

-(void)applicationWillTerminate:(UIApplication *)application {
	MCAppDataModel *dataModel = [MCAppDataModel sharedDataModel];
	[[dataModel mainContext] save:nil];
}

- (BOOL)handleOpenURL:(NSURL*)url{
	NSString* scheme = [url scheme];
	if ([scheme hasPrefix:[NSString stringWithFormat:@"fb%@", SHKCONFIG(facebookAppId)]])
		return [SHKFacebook handleOpenURL:url];
	return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
	return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url{
	return [self handleOpenURL:url];
}



@end
