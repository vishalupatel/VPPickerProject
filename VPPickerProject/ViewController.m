//
//  ViewController.m
//  VPPickerProject
//
//  Created by Vishal Patel on 29/04/16.
//  Copyright © 2016 Vishal Patel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.txtDate) {
        textField.inputAccessoryView = [[VPKeyboardToolBar SharedInstance] KeyboardToolBarSetForText:textField
                                                                                PreviousButtonEnable:NO
                                                                                    NextButtonEnable:YES
                                                                                            Delegate:self];
        
        textField.inputView = [[VPPicker SharedInstance] getDatePickerWithResultingFormat:@"yyyy-MM-dd"
                                                                               setMinDate:nil
                                                                               setMaxDate:[NSDate date]
                                                                                     mode:UIDatePickerModeDateAndTime
                                                                             WithDeledate:self
                                                                             forTextInput:textField];
    }
    else if (textField == self.txtList) {
        textField.inputAccessoryView = [[VPKeyboardToolBar SharedInstance] KeyboardToolBarSetForText:textField PreviousButtonEnable:YES NextButtonEnable:NO Delegate:self];
        
        textField.inputView = [[VPPicker SharedInstance] getPickerWithListForTextInput:textField
                                                                          WithDeledate:self
                                                                                ForKey:@"title"
                                                                              FromData:[self tempArray]];
    }
    return YES;
}

#pragma mark - VPPicker Delegate method
- (void)setPickerResult:(id)result forTextInput:(id)inp;
{
    if ((UITextField *)inp == _txtDate) {
        ((UITextField *)inp).text = result;
    }
    else if ((UITextField *)inp == _txtList) {
        
        ((UITextField *)inp).text = [(NSDictionary *)result valueForKey:@"title"];
    }
}

#pragma mark - VPKeyboardToolBar Delegate method
- (void)nextButtonIsClicked:(id)sender forTextInput:(id)inp
{
    if ((UITextField *)inp == self.txtDate)
    {
        [_txtList becomeFirstResponder];
    }
}

- (void)previousButtonIsClicked:(id)sender forTextInput:(id)inp
{
    if ((UITextField *)inp == self.txtList)
    {
        [_txtDate becomeFirstResponder];
    }
}

- (void)doneButtonIsClicked:(id)sender forTextInput:(id)inp
{
    [(UITextField *)inp resignFirstResponder];
}

#pragma mark - Create Temp Array
- (NSMutableArray *)tempArray
{
    NSMutableArray *arrData = [[NSMutableArray alloc]init];
    
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:@"India" forKey:@"title"];
        [dic setValue:@"1" forKey:@"id"];
        [arrData addObject:dic];
    }
    
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:@"USA" forKey:@"title"];
        [dic setValue:@"2" forKey:@"id"];
        [arrData addObject:dic];
    }
    
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:@"UK" forKey:@"title"];
        [dic setValue:@"3" forKey:@"id"];
        [arrData addObject:dic];
    }
    
    return arrData;
}
@end
