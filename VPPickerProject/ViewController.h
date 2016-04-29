//
//  ViewController.m
//  VPPickerProject
//
//  Created by Vishal Patel on 29/04/16.
//  Copyright © 2016 Vishal Patel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPPicker.h"
#import "VPKeyboardToolBar.h"
@interface ViewController : UIViewController<UITextFieldDelegate,VPPickerDelegate,VPKeyboardToolBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtList;

@end

