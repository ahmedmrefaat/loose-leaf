//
//  SLPaperStackView.h
//  Paper Stack
//
//  Created by Adam Wulf on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLPaperView.h"
#import "SLPanGestureRecognizer.h"
#import "SLPinchGestureRecognizer.h"

@interface SLPaperStackView : UIView{
    NSMutableArray* visibleStack;
    NSMutableArray* hiddenStack;
}

-(void) addPaperToBottomOfStack:(SLPaperView*)page;

@end
