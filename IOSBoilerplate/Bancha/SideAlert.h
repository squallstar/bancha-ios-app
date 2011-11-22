//
//  SideAlert.h
//  Bancha
//
//  Created by Nicholas Valbusa on 22/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideAlert : UIView {
	UILabel *textLabel;
}

-(void)setText:(NSString*)newText;

-(id)initInFrame:(CGRect)frame WithTitle:(NSString*)title;
-(void)fire;

-(void)remove;
-(void)removeAnimated;

-(void)fireAndRemoveAfter:(CGFloat)seconds;

@property (nonatomic, retain) UILabel *textLabel;

@end
