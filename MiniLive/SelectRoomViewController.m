//
//  SelectRoomViewController.m
//  MiniLive
//
//  Created by hehe on 2017/12/21.
//  Copyright © 2017年 HEHE. All rights reserved.
//

#import "SelectRoomViewController.h"
#import "MLSession.h"
#import "MLResponse.h"

@interface SelectRoomViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSIndexPath *lastIndexPath;
@end

@implementation SelectRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return [MLSession shareInstance].roomList.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLRoom *room = [MLSession shareInstance].roomList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = room.name;
    
    if([room.id isEqualToString:[MLSession shareInstance].roomID])
    {
        self.lastIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

#pragma mark Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger newRow = indexPath.row;
    
    NSInteger oldRow = (self.lastIndexPath != nil) ? self.lastIndexPath.row : newRow;
    
    if(newRow != oldRow)
    {
        UITableViewCell *newcell = [tableView cellForRowAtIndexPath:indexPath];
        newcell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldcell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
        oldcell.accessoryType = UITableViewCellAccessoryNone;
        
        __weak MLSession *session = [MLSession shareInstance];
        session.roomID = ((MLRoom*)session.roomList[indexPath.row]).id;
        self.lastIndexPath = indexPath;
    }
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
