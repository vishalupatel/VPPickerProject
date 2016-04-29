//
//  ViewController.m
//  VPPickerProject
//
//  Created by Vishal Patel on 29/04/16.
//  Copyright © 2016 Vishal Patel. All rights reserved.
//

#import "VPKeyboardToolBar.h"
#import "AppDelegate.h"
#define appDel ((AppDelegate*)[[UIApplication sharedApplication] delegate])
@implementation VPKeyboardToolBar

VPKeyboardToolBar * sharedKeyboardToolBar;

+ (VPKeyboardToolBar *) SharedInstance {
    if (sharedKeyboardToolBar != nil) {
        return sharedKeyboardToolBar;
    }
    sharedKeyboardToolBar = [[VPKeyboardToolBar alloc] init];
    return sharedKeyboardToolBar;
}

- (UIToolbar *)KeyboardToolBarSetForText:(id)sender PreviousButtonEnable:(BOOL)preBtn NextButtonEnable:(BOOL)nextBtn Delegate:(id<VPKeyboardToolBarDelegate>)delegateObj
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, appDel.window.frame.size.width, 44);
    [toolbar setBarStyle:UIBarStyleDefault];
    
    previousBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Previous", @"Previous") style:UIBarButtonItemStylePlain target:self action:@selector(previousButtonIsClicked:)];
    nextBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", @"Next") style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonIsClicked:)];
    doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonIsClicked:)];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    inputView = sender;
    delegate = delegateObj;
    nextBarButton.enabled = nextBtn;
    previousBarButton.enabled = preBtn;
    
    NSArray *barButtonItems = @[previousBarButton, nextBarButton, flexBarButton, doneBarButton];
    toolbar.items = barButtonItems;
    
    return toolbar;
}


- (void)nextButtonIsClicked:(id)sender
{
    if ([delegate respondsToSelector:@selector(nextButtonIsClicked:forTextInput:)]) {
        [delegate performSelector:@selector(nextButtonIsClicked:forTextInput:) withObject:sender withObject:inputView];
    }
}

- (void)previousButtonIsClicked:(id)sender
{
    if ([delegate respondsToSelector:@selector(previousButtonIsClicked:forTextInput:)]) {
        [delegate performSelector:@selector(previousButtonIsClicked:forTextInput:) withObject:sender withObject:inputView];
    }
}

- (void)doneButtonIsClicked:(id)sender
{
    if ([delegate respondsToSelector:@selector(doneButtonIsClicked:forTextInput:)]) {
        [delegate performSelector:@selector(doneButtonIsClicked:forTextInput:) withObject:sender withObject:inputView];
    }
}
@end
