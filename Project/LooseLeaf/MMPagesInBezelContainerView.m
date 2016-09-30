//
//  MMPagesInBezelContainerView.m
//  LooseLeaf
//
//  Created by Adam Wulf on 9/27/16.
//  Copyright © 2016 Milestone Made, LLC. All rights reserved.
//

#import "MMPagesInBezelContainerView.h"
#import "MMPageBubbleButton.h"
#import "NSThread+BlockAdditions.h"
#import "MMImmutableScrapsOnPaperState.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "NSFileManager+DirectoryOptimizations.h"
#import "MMRotationManager.h"
#import "UIView+Debug.h"
#import "MMImmutableScrapsInSidebarState.h"
#import "MMTrashManager.h"
#import "MMSidebarButtonTapGestureRecognizer.h"

#define kAnimationDuration 0.3


@implementation MMPagesInBezelContainerView

@dynamic bubbleDelegate;

- (id)initWithFrame:(CGRect)frame andCountButton:(MMCountBubbleButton*)_countButton {
    if (self = [super initWithFrame:frame andCountButton:_countButton]) {
        contentView = [[MMCountableSidebarContentView alloc] initWithFrame:[slidingSidebarView contentBounds]];
        contentView.delegate = self;
        [slidingSidebarView addSubview:contentView];
    }
    return self;
}

#pragma mark - MMCountableSidebarContainerView

- (MMPageBubbleButton*)newBubbleForView:(MMEditablePaperView*)scrap {
    MMPageBubbleButton* bubble = [[MMPageBubbleButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    bubble.originalViewScale = scrap.scale;
    return bubble;
}

- (void)addViewToCountableSidebar:(MMEditablePaperView*)page animated:(BOOL)animated {
    // make sure we've saved its current state
    if (animated) {
        // only save when it's animated. non-animated is loading
        // from disk at start up
        [page saveToDisk:nil];
    }

    // unload the scrap state, so that it shows the
    // image preview instead of an editable state
    [page unloadState];

    [super addViewToCountableSidebar:page animated:animated];
}

- (void)deleteAllViewsFromSidebar {
    for (MMEditablePaperView* page in [[self viewsInSidebar] copy]) {
        [[MMTrashManager sharedInstance] deletePage:page];
    }

    [super deleteAllViewsFromSidebar];

    [self saveScrapContainerToDisk];
}

- (void)loadCachedPreviewForView:(MMEditablePaperView*)view {
    [view loadCachedPreview];
}

- (void)unloadCachedPreviewForView:(MMEditablePaperView*)view {
    [view unloadCachedPreview];
}

#pragma mark - Save and Load

static NSString* bezelStatePath;

+ (NSString*)pathToPlist {
    if (!bezelStatePath) {
        NSString* documentsPath = [NSFileManager documentsPath];
        NSString* bezelStateDirectory = [documentsPath stringByAppendingPathComponent:@"Bezel"];
        [NSFileManager ensureDirectoryExistsAtPath:bezelStateDirectory];
        bezelStatePath = [[bezelStateDirectory stringByAppendingPathComponent:@"page-sidebar"] stringByAppendingPathExtension:@"plist"];
    }
    return bezelStatePath;
}

- (void)saveScrapContainerToDisk {
    @throw [NSException exceptionWithName:@"NeedsImplementationException" reason:@"This method is not implemented" userInfo:nil];
}

- (void)loadFromDisk {
    @throw [NSException exceptionWithName:@"NeedsImplementationException" reason:@"This method is not implemented" userInfo:nil];
}

@end
