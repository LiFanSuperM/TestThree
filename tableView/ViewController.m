//
//  ViewController.m
//  tableView
//
//  Created by youli  on 15/11/25.
//  Copyright © 2015年 youli . All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_array;
    NSArray *_dataArray;
    NSArray *_sortedArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configData];
    [self configKeyArray];
    [self configView];
}
- (void)configData
{
    _array = [NSMutableArray arrayWithObjects:
              @"#",@"A", @"B", @"C", @"D", @"E", @"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    _dataArray = @[@"李冰冰",@"范冰冰",@"啊2-成",@"b哥",@"小丽",@"郑冰",@"赵薇",@"徐整",@"Haha",@"hahaha",@"李凡",@"王征",@"牛逼",@"Dell",@"MAC PRO",@"000",@"你猜",@"张帆",@"王利",@"啊1-成",@"李逵"];
}
- (void)configKeyArray
{
    // 1.找出每个名字的首字母
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (int num = 0; num < _dataArray.count; num++)
    {
        // 找出数组中的每个名字
        NSString *nameString = _dataArray[num];
        // 找出名字中的数字母
        NSString *finString = [self firstCharactor:nameString];
        // 找出数组后, 匹配上对应的名字
        NSString *finNameString = [NSString stringWithFormat:@"%@%@",finString,nameString];
        // 将首字母和名字组合在一起的字符串拼接起来加入到新的数组中
        [array addObject:finNameString];
    }
    // 将数组中的每个数据进行比较后加入新的数组中
    
    // 此时新的数组大概样式为 ,A啊成,Bb哥,DDell,F范冰冰......
     _sortedArray= [array sortedArrayUsingSelector:@selector(compare:)];
}
- (void)configView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.sectionIndexColor = [UIColor redColor];
}
#pragma mark -
#pragma mark 表的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sortedArray.count;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _sortedArray.count;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    NSString *nameString = _sortedArray[indexPath.row];
    NSString *finString = [nameString substringFromIndex:1];
    cell.textLabel.text = finString;
    return cell;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    return _array ;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index

{
    // 判断选中的title和每个名字的大小字符串的关系,如果在数组中有一个名字的首字符和选中的title相同,就把表的选中状态改变,跳出方法,如果没有就返回一个空得值
    static  NSInteger selectIndex = 0;
    
    if ([title isEqualToString:@"#"])
    {
        return 0;
    }else
    {
        
    for (NSInteger num = 0 ; num < _sortedArray.count ; num++)
      {
        NSString *string = _sortedArray[num];
        NSString *fristString = [string substringToIndex:1];
        if ([title isEqualToString:fristString])
         {
            selectIndex = num;
            [tableView
             scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:selectIndex inSection:0]
             atScrollPosition:UITableViewScrollPositionTop animated:YES];
         }
       }
    return selectIndex;
    }
    
}
#pragma mark -
#pragma 获取字符串的首字符
- (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}
@end
