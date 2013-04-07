//
//  MCContentView.h
//  CityOutdoors
//
//  Created by Marius Ciocanel on 14/01/2013.
//  Copyright (c) 2013 Marius Ciocanel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol MCContentImageInteractionProtocol <NSObject>
@required
-(void)showImageForContentWithID:(NSNumber*)commentID;
@end

@class MCContent;
@interface MCContentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) id<MCContentImageInteractionProtocol> delegate;
-(void)populateFromContent:(MCContent*)content;

@end
