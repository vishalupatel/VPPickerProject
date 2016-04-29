//
//  ViewController.m
//  VPPickerProject
//
//  Created by Vishal Patel on 29/04/16.
//  Copyright © 2016 Vishal Patel. All rights reserved.
//

#import "VPPicker.h"

@implementation VPPicker

VPPicker * sharedDatePicker;

+ (VPPicker *) SharedInstance {
    if (sharedDatePicker != nil) {
        return sharedDatePicker;
    }
    sharedDatePicker = [[VPPicker alloc] init];
    return sharedDatePicker;
}

- (UIDatePicker *)getDatePickerWithResultingFormat:(NSString *)dateFormatObj setMinDate:(NSDate *)minDate setMaxDate:(NSDate *)maxDate mode:(UIDatePickerMode)datePMode WithDeledate:(id<VPPickerDelegate>)dele forTextInput:(id)inputTextField
{
    inputView = inputTextField;
    delegate = dele;
    dateFormat = dateFormatObj;
    
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = datePMode;
    
    if (maxDate != nil) {
        datePicker.maximumDate = maxDate;
    }
    
    if (minDate != nil) {
        datePicker.minimumDate = minDate;
    }
    
    if (![((UITextField *)inputTextField).text isEqualToString:@""]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if (dateFormat) {
            [dateFormatter setDateFormat:dateFormat];
        } else {
            [dateFormatter setDateFormat:@"MM/dd/YY"];
        }

        NSDate *selectedDate = [dateFormatter dateFromString:((UITextField *)inputTextField).text];
        
        if (selectedDate != nil)
            [datePicker setDate:selectedDate];
    }else{
        NSDate *selectedDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        if (dateFormat) {
            [dateFormatter setDateFormat:dateFormat];
        } else {
            [dateFormatter setDateFormat:@"MM/dd/YY"];
        }
        NSString *str = [dateFormatter stringFromDate:selectedDate];

        if ([delegate respondsToSelector:@selector(setPickerResult:forTextInput:)]) {
            [delegate performSelector:@selector(setPickerResult:forTextInput:) withObject:str withObject:inputView];
        }
    }
    
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    return datePicker;
}

- (void)datePickerValueChanged:(id)sender{
    UIDatePicker *datePickerObj = (UIDatePicker*)sender;
    
    NSDate *selectedDate = datePickerObj.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (dateFormat) {
        [dateFormatter setDateFormat:dateFormat];
    } else {
        [dateFormatter setDateFormat:@"MM/dd/YY"];
    }
    NSString *str = [dateFormatter stringFromDate:selectedDate];
    
    if ([delegate respondsToSelector:@selector(setPickerResult:forTextInput:)]) {
        [delegate performSelector:@selector(setPickerResult:forTextInput:) withObject:str withObject:inputView];
    }
}


- (UIPickerView *)getPickerWithListForTextInput:(id)inputTextField WithDeledate:(id<VPPickerDelegate>)dele ForKey:(NSString *)key FromData:(NSMutableArray *)list
{
    listKey = key;
    inputView = inputTextField;
    delegate = dele;
    
    dataArray = [[NSArray alloc] initWithArray:list];
    pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    if (![self isEmpty:((UITextField *)inputTextField).text]) {
        for (int x = 0; x < [dataArray count]; x++) {
            if ([((UITextField *)inputTextField).text isEqualToString:[[dataArray objectAtIndex:x] valueForKey:key]]) {
                [pickerView selectRow:x inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        if ([delegate respondsToSelector:@selector(setPickerResult:forTextInput:)]) {
            [delegate performSelector:@selector(setPickerResult:forTextInput:) withObject:[dataArray objectAtIndex:0] withObject:inputView];
        }
    }
    
    return pickerView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([delegate respondsToSelector:@selector(setPickerResult:forTextInput:)]) {
        [delegate performSelector:@selector(setPickerResult:forTextInput:) withObject:[dataArray objectAtIndex:row] withObject:inputView];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataArray count];
}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[dataArray objectAtIndex:row] valueForKey:listKey];
}

#pragma Mark - Validation
- (BOOL) isEmpty:(NSString *)strData
{
    return [[strData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""];
}
@end
