//
//  ViewController.m
//  VPPickerProject
//
//  Created by Vishal Patel on 29/04/16.
//  Copyright © 2016 Vishal Patel. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol VPKeyboardToolBarDelegate <NSObject>

@optional
- (void)nextButtonIsClicked:(id)sender forTextInput:(id)inp;
- (void)previousButtonIsClicked:(id)sender forTextInput:(id)inp;
- (void)doneButtonIsClicked:(id)sender forTextInput:(id)inp;

@end

@interface VPKeyboardToolBar : NSObject
{
    id<VPKeyboardToolBarDelegate> delegate;
    id inputView;
    
    UIBarButtonItem *previousBarButton;
    UIBarButtonItem *nextBarButton;
    UIBarButtonItem *doneBarButton;
}

- (UIToolbar *)KeyboardToolBarSetForText:(id)sender PreviousButtonEnable:(BOOL)preBtn NextButtonEnable:(BOOL)nextBtn Delegate:(id<VPKeyboardToolBarDelegate>)delegateObj;

+ (VPKeyboardToolBar *) SharedInstance;
- (void)nextButtonIsClicked:(id)sender;
- (void)previousButtonIsClicked:(id)sender;
- (void)doneButtonIsClicked:(id)sender;
@end
