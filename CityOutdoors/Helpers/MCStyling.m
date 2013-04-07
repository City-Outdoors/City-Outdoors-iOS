//
//  MCStyling.m
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import "MCStyling.h"

@implementation MCStyling

+(void)styleApplication {
	UIColor *greenTextColor = [[self class] greenTextColor];
	[[UIBarButtonItem appearance] setTitleTextAttributes:@{
							   UITextAttributeTextColor : [UIColor grayColor],
									UITextAttributeFont : [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:15] }
												forState:UIControlStateNormal];
	[[UIBarButtonItem appearance] setTintColor:greenTextColor];
	UIOffset backTextOffset = UIOffsetMake(1, -2);;
	[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:backTextOffset forBarMetrics:UIBarMetricsDefault];
    
	UIOffset shadowOffset = UIOffsetMake(0, -1);
    [[UINavigationBar appearance] setTitleTextAttributes:@{
									UITextAttributeFont : [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20],
							   UITextAttributeTextColor : greenTextColor,
						 UITextAttributeTextShadowColor : [UIColor whiteColor],
						UITextAttributeTextShadowOffset : [NSValue value:&shadowOffset withObjCType:@encode(UIOffset)]}];
	UIColor *offWhiteBarTint = [UIColor colorWithRed:148/255.0 green:27/255.0 blue:42/255.0 alpha:1];
	[[UINavigationBar appearance] setTintColor:offWhiteBarTint];
	[[UIToolbar appearance] setTintColor:offWhiteBarTint];
	
}

+(void)styleButtonWithCustomBackground:(UIButton*)button {
	UIImage *buttonBackground = [[UIImage imageNamed:@"button_green_background.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:15];
	[button.titleLabel setFont:[[self class] buttonTextFont]];
	[button setTitleColor:[[self class] buttonTextColor] forState:UIControlStateNormal];
	[[self class] configureButton:button withBackgroundImage:buttonBackground];
}


+(void)configureButton:(UIButton*)button withBackgroundImage:(UIImage*)bgImage {
	[button setBackgroundImage:bgImage forState:UIControlStateNormal];
	[button setBackgroundImage:bgImage forState:UIControlStateHighlighted];
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}

+(UIColor*)buttonTextColor {
	return [UIColor grayColor];
}

+(UIFont*)buttonTextFont {
	return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
}

+(UIFont*)textFontOfSize:(int)fontSize {
	return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:fontSize];
}

+(UIColor*)greenTextColor {
	return [UIColor colorWithRed:66/255.0 green:169/255.0 blue:196/255.0 alpha:1];
}

+(UIColor*)featureHeaderColor {
	return [UIColor colorWithRed:99/255.0 green:166/255.0 blue:155/255.0 alpha:1];
}

+(UIColor*)contentTextColor {
	return [UIColor blackColor];
}

+(UIImage*)underMenuImage {
	return [UIImage imageNamed:@"ImagePlaceholder.png"];
}

+(UIImage*)imagePlaceholder {
	return [UIImage imageNamed:@"ImagePlaceholder.png"];
}
@end
