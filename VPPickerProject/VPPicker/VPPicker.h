//
//  ViewController.m
//  VPPickerProject
//
//  Created by Vishal Patel on 29/04/16.
//  Copyright © 2016 Vishal Patel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol VPPickerDelegate <NSObject>
@optional
- (void)setPickerResult:(id)result forTextInput:(id)inp;
@end

@interface VPPicker : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>
{
    id<VPPickerDelegate> delegate;
    id inputView;
    
    UIDatePicker *datePicker;
    UIPickerView *pickerView;
    
    NSArray *dataArray;
    
    NSString *dateFormat;
    NSString *listKey;
    
    NSMutableDictionary *dicData;
}

+ (VPPicker *) SharedInstance;

- (UIDatePicker *)getDatePickerWithResultingFormat:(NSString *)dateFormatObj setMinDate:(NSDate *)minDate setMaxDate:(NSDate *)maxDate mode:(UIDatePickerMode)datePMode WithDeledate:(id<VPPickerDelegate>)dele forTextInput:(id)inputTextField;

- (UIPickerView *)getPickerWithListForTextInput:(id)inputTextField WithDeledate:(id<VPPickerDelegate>)dele ForKey:(NSString *)key FromData:(NSMutableArray *)list;
@end
