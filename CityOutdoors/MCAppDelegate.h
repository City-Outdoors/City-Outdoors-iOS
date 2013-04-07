//
//  MCAppDelegate.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 17/10/2012.
//  Copyright (c) 2012 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;
@interface MCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JASidePanelController *viewController;

@end
