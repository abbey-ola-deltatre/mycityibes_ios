//
//  MusicCategoryViewController.m
//  VOS
//
//  Created by Abbey Ola on 03/12/2016.
//  Copyright © 2016 aufree. All rights reserved.
//

#import "MusicCategoryViewController.h"

@interface MusicCategoryViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;
@property (weak, nonatomic) IBOutlet UIButton *djmixbutton;
@property (weak, nonatomic) IBOutlet UIButton *trendingbutton;
@property (weak, nonatomic) IBOutlet UIButton *ybnl;
@property (weak, nonatomic) IBOutlet UIButton *newbies;
@property (weak, nonatomic) IBOutlet UIButton *oldschool;
@property (weak, nonatomic) IBOutlet UIButton *mavin;
@property (weak, nonatomic) IBOutlet UIButton *myselection;
@property (weak, nonatomic) IBOutlet UIButton *gospel;
@property (weak, nonatomic) IBOutlet UILabel *djlabel;
@property (weak, nonatomic) IBOutlet UILabel *nxlabel;
@property (weak, nonatomic) IBOutlet UILabel *mavinlabel;
@property (weak, nonatomic) IBOutlet UILabel *gospellabel;

@end

@implementation MusicCategoryViewController

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scrolView layoutIfNeeded];
    _scrolView.contentSize = _contentView.bounds.size;
    [ self.navigationController.navigationBar setBarTintColor :[ UIColor colorWithRed:0.0 green:0.5 blue:0.2 alpha:1]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)
    {
       CGSize frame = CGSizeMake(144, 140);
        
        CGRect ybnlFrame = _ybnl.frame;
        CGRect newbiesFrame = _newbies.frame;
        CGRect oldschoolFrame = _oldschool.frame;
        CGRect mavinFrame = _mavin.frame;
        CGRect myselectionFrame = _myselection.frame;
        CGRect gospelFrame = _gospel.frame;
        CGRect trendingFrame = _trendingbutton.frame;
        CGRect djmixFrame = _djmixbutton.frame;
        
        ybnlFrame.size = frame;
        newbiesFrame.size = frame;
        mavinFrame.size = frame;
        oldschoolFrame.size = frame;
        myselectionFrame.size = frame;
        gospelFrame.size = frame;
        djmixFrame.size = frame;
        trendingFrame.size = frame;
        
        _ybnl.frame = ybnlFrame;
        _gospel.frame = gospelFrame;
        _myselection.frame = myselectionFrame;
        _mavin.frame = mavinFrame;
        _newbies.frame = newbiesFrame;
        _oldschool.frame = oldschoolFrame;
        _djmixbutton.frame = djmixFrame;
        _trendingbutton.frame = trendingFrame;
        
        _newbies.frame = CGRectOffset(_newbies.frame, -20, 0);
        _djmixbutton.frame = CGRectOffset(_djmixbutton.frame, -20, 0);
        _mavin.frame = CGRectOffset(_mavin.frame, -20, 0);
        _gospel.frame = CGRectOffset(_gospel.frame, -20, 0);
        _gospellabel.frame = CGRectOffset(_gospellabel.frame, -20, 0);
        _mavinlabel.frame = CGRectOffset(_mavinlabel.frame, -20, 0);
        _nxlabel.frame = CGRectOffset(_nxlabel.frame, -20, 0);
        _djlabel.frame = CGRectOffset(_djlabel.frame, -20, 0);
        
    }
    
    else if (IS_IPHONE_6P)
    {
        _newbies.frame = CGRectOffset(_newbies.frame, 30, 0);
        _djmixbutton.frame = CGRectOffset(_djmixbutton.frame, 30, 0);
        _mavin.frame = CGRectOffset(_mavin.frame, 30, 0);
        _gospel.frame = CGRectOffset(_gospel.frame, 30, 0);
        _gospellabel.frame = CGRectOffset(_gospellabel.frame, 30, 0);
        _mavinlabel.frame = CGRectOffset(_mavinlabel.frame, 30, 0);
        _nxlabel.frame = CGRectOffset(_nxlabel.frame, 30, 0);
        _djlabel.frame = CGRectOffset(_djlabel.frame, 30, 0);
        
    }
}


@end
