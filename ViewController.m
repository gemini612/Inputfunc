//
//  ViewController.m
//  InputFunc
//
//  Created by Zhu Jicheng on 15/8/6.
//  Copyright (c) 2015年 Zhu Jicheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.‘
    // self.view.backgroundColor = [UIColor orangeColor];
    
    
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 162)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    
    [self.pickerView reloadAllComponents];//刷新UIPickerView
    
    _nameArray = [NSArray arrayWithObjects:@"北京",@"上海",@"广州",@"深圳",@"重庆",@"武汉",@"天津",nil];
    
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 80)];
    [self.view addSubview:self.datePicker];
    
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];//重点：UIControlEventValueChanged
    
    //设置显示格式
    //默认根据手机本地设置显示为中文还是其他语言
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    self.datePicker.locale = locale;
    
    
    //当前时间创建NSDate
    NSDate *localDate = [NSDate date];
    //在当前时间加上的时间：格里高利历
    NSCalendar *Chinese = [[NSCalendar alloc] initWithCalendarIdentifier: NSLocaleIdentifier];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    //设置时间
    [offsetComponents setYear:0];
    [offsetComponents setMonth:0];
    [offsetComponents setDay:0];
    [offsetComponents setHour:0];
    [offsetComponents setMinute:30];
    [offsetComponents setSecond:0];
    //设置最大值时间
    NSDate *maxDate = [Chinese dateByAddingComponents:offsetComponents toDate:localDate options:0];
    //设置属性
    self.datePicker.minimumDate = localDate;
    self.datePicker.maximumDate = maxDate;
    
    
    _showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.datePicker.frame)+20, CGRectGetWidth(self.datePicker.frame), 30)];
    _showLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _showLabel.textAlignment = NSTextAlignmentCenter;
    _showLabel.text = @"显示获取的日期时间";
    [self.view addSubview:_showLabel];
    
}

-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    //添加你自己响应代码
    NSLog(@"dateChanged响应事件：%@",date);
    
    //NSDate格式转换为NSString格式
    NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy年MM月dd日(EEEE)   HH:mm:ss"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    //打印显示日期时间
    NSLog(@"格式化显示时间：%@",dateString);
    _showLabel.text = dateString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark pickerview function

//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return  5;
    } else if(component==1){
        
        return  [_nameArray count];
    }
    return [_nameArray count];
}
//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 20.0f;
}
//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {//iOS6边框占10+10
        return  self.view.frame.size.width/3;
    } else if(component==1){
        return  self.view.frame.size.width/3;
    }
    return  self.view.frame.size.width/3;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, 20)];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = [_nameArray objectAtIndex:row];
    [view addSubview:text];
    
    return view;
}
//显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = [_nameArray objectAtIndex:row];
    return str;
}
//显示的标题字体、颜色等属性
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = [_nameArray objectAtIndex:row];
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    
    return AttributedString;
}//NS_AVAILABLE_IOS(6_0);

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"HANG%@",[_nameArray objectAtIndex:row]);
    
}


/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end