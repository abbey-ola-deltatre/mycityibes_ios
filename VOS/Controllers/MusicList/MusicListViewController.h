//
//  MusicListViewController.h
//  Enesco
//
//  Created by Aufree on 11/30/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "UIViewController+RESideMenu.h"
#import "RECommonFunctions.h"
@protocol MusicListViewControllerDelegate <NSObject>
- (void)playMusicWithSpecialIndex:(NSInteger)index;
@end

@interface MusicListViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *musicEntitiesSelection;
@property (nonatomic, weak) id <MusicListViewControllerDelegate> delegate;
@end
