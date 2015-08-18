//
//  ViewController.h
//  InputFunc
//
//  Created by Zhu Jicheng on 15/8/6.
//  Copyright (c) 2015年 Zhu Jicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSArray *_nameArray;
    
    UILabel *_showLabel;
    
}

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (strong, nonatomic) UIPickerView *pickerView;

@end
