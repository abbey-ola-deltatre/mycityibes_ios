//
//  MenuViewController.h
//  Enesco
//
//  Created by Abbey Ola on 08/10/2016.
//  Copyright © 2016 aufree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *greeting;
-(void) getUserFBName;
@end
