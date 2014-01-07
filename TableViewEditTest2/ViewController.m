//
//  ViewController.m
//  TableViewEditTest2
//
//  Created by Lee HyunYoung on 2014. 1. 7..
//  Copyright (c) 2014년 Lee HyunYoung. All rights reserved.
//

#import "ViewController.h"
#define CELL_ID @"CELL_ID"
@interface ViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UITextField *userInput;

@end

@implementation ViewController {
    NSMutableArray *data;
}

- (IBAction)toggleEditMode:(id)sender {
    self.table.editing = !self.table.editing;
    ((UIBarButtonItem *) sender).title = self.table.editing ? @"Done" : @"Edit";
}
- (IBAction)addItem:(id)sender {
    NSString *inputStr = self.userInput.text;
    if ([inputStr length] > 0) {
        //데이터 추가
        [data addObject:inputStr];
        
        //테이블에 셀 추가
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count] -1) inSection:0];
        NSArray *row = @[indexPath];
        [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
        
        //텍스트필드 초기화
        self.userInput.text = @"";
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    
    return cell;
}

//셀 편집 승인 작업
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //data delete
        [data removeObjectAtIndex:indexPath.row];
        //table view cell delete
        NSArray *rows = @[indexPath];
        [tableView deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
//편집 가능 여부
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//셀 이동
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSObject *obj = [data objectAtIndex:sourceIndexPath.row];
    [data removeObjectAtIndex:sourceIndexPath.row];
    [data insertObject:(NSArray *)obj atIndex:destinationIndexPath.row];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self addItem:nil];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [[NSMutableArray alloc]init];
}

//새 데이터 추가 - 셀반영


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
