//
//  MCStyling.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 06/02/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCStyling : NSObject
+(void)styleApplication;
+(void)styleButtonWithCustomBackground:(UIButton*)button;
+(void)configureButton:(UIButton*)button withBackgroundImage:(UIImage*)bgImage;
+(UIColor*)buttonTextColor;
+(UIFont*)buttonTextFont;
+(UIFont*)textFontOfSize:(int)fontSize;
+(UIColor*)greenTextColor;
+(UIColor*)featureHeaderColor;
+(UIColor*)contentTextColor;
+(UIImage*)underMenuImage;
+(UIImage*)imagePlaceholder;
@end
