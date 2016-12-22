//
//  ViewController.m
//  EditTableView
//
//  Created by X-Designer on 16/12/22.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import "ViewController.h"
#import "GDTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) UIButton *edit_button;

@property (nonatomic, strong) UIButton *all_button;

@property (nonatomic, strong) UIButton *delete_button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectedArray = [NSMutableArray array];
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate  = self;
    _tableView.dataSource = self;
    _tableView.allowsSelectionDuringEditing = YES;
    [self.view addSubview:_tableView];
    
    _edit_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_edit_button setTitle:@"编辑" forState:UIControlStateNormal];
    [_edit_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _edit_button.frame = CGRectMake(10, 20, 50, 40);
    [self.view addSubview:_edit_button];
    [_edit_button addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _all_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_all_button setTitle:@"全选" forState:UIControlStateNormal];
    [_all_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _all_button.frame = CGRectMake(self.view.frame.size.width - 100, 20, 50, 40);
    [self.view addSubview:_all_button];
    [_all_button addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _all_button.hidden = YES;

    _delete_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_delete_button setTitle:@"删除" forState:UIControlStateNormal];
    [_delete_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _delete_button.frame = CGRectMake(self.view.frame.size.width - 60, 20, 50, 40);
    _delete_button.center = CGPointMake(self.view.frame.size.width/2, 40);
    [self.view addSubview:_delete_button];
    [_delete_button addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _delete_button.hidden = YES;
}
#pragma mark - 编辑
- (void)editButtonClick:(UIButton *)sender {
    if (_tableView.editing) {
        [_tableView setEditing:NO animated:YES];
        _delete_button.hidden = YES;
        _all_button.hidden = YES;
        if (_all_button.selected)_all_button.selected = !_all_button.selected;
        [_selectedArray removeAllObjects];
    }else{
        [_tableView setEditing:YES animated:YES];
        _all_button.hidden = NO;
    }
}
#pragma mark - 全选
- (void)allButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        for (int i=0; i<_dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
        }
        //全部添加到选择数组
        [_selectedArray removeAllObjects];
        [_selectedArray addObjectsFromArray:_dataArray];
        _delete_button.hidden = NO;
    }else{
        for (int i=0; i<_dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [_tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        //全部从算则数组中删除
        [_selectedArray removeAllObjects];
        _delete_button.hidden = YES;
    }
NSLog(@"count-%ld",_selectedArray.count);
}
#pragma mark - 删除
- (void)deleteButtonClick:(UIButton *)sender {

    if (_tableView.editing) {
        if (_selectedArray.count == 0) {
            NSLog(@"请选择商品");
            return;
        }
        [_dataArray removeObjectsInArray:_selectedArray];
        [_tableView reloadData];
        if (_dataArray.count == 0) {
            [_tableView setEditing:NO animated:YES];
            _delete_button.hidden = YES;
            _all_button.hidden = YES;
            if (_all_button.selected)_all_button.selected = !_all_button.selected;
            [_selectedArray removeAllObjects];

        }
    }
//    [_dataArray removeLastObject];
//    [_tableView reloadData];
    _delete_button.hidden = YES;

}
#pragma mark - 删除deledate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.editing) {
//        NSLog(@"select-%ld",indexPath.row);
        [_selectedArray addObject:_dataArray[indexPath.row]];
        if (_selectedArray.count>0) {
            _delete_button.hidden = NO;
        }
        NSLog(@"count-%ld",_selectedArray.count);

    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.editing) {
//        NSLog(@"deselect-%ld",indexPath.row);
        [_selectedArray removeObject:_dataArray[indexPath.row]];
        if (_selectedArray.count>0) {
            _delete_button.hidden = NO;
        }else _delete_button.hidden = YES;
        NSLog(@"count-%ld",_selectedArray.count);
    }
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tableView.editing) {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cell";
    GDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[GDTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 44)];
    label.text = _dataArray[indexPath.row];
    [cell.contentView addSubview:label];
//    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
