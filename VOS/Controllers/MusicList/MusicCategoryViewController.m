//
//  MusicCategoryViewController.m
//  VOS
//
//  Created by Abbey Ola on 03/12/2016.
//  Copyright © 2016 aufree. All rights reserved.
//

#import "MusicCategoryViewController.h"
#import "MusicIndicator.h"
#import "MusicViewController.h"
#import "MBProgressHUD.h"

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
- (IBAction)djmix:(id)sender
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
     musicVC.musicTitle = @"dj mix";
    [self performSegueWithIdentifier:@"gototable" sender:self];
}

- (IBAction)trending:(id)sender
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = @"as e dey hot";
    [self performSegueWithIdentifier:@"gototable" sender:self];
}

- (IBAction)ybnl:(id)sender
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = @"ybnl nation";
    [self performSegueWithIdentifier:@"gototable" sender:self];
}

- (IBAction)newbies:(id)sender
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = @"next rated";
    [self performSegueWithIdentifier:@"gototable" sender:self];
}

- (IBAction)oldies:(id)sender
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = @"old school";
    [self performSegueWithIdentifier:@"gototable" sender:self];
}

- (IBAction)maven:(id)sender
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = @"maven";
    [self performSegueWithIdentifier:@"gototable" sender:self];
}
- (IBAction)myselection:(id)sender
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = @"my selection";
    [self performSegueWithIdentifier:@"gototable" sender:self];
}
- (IBAction)gospel:(id)sender
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = @"gospel";
    [self performSegueWithIdentifier:@"gototable" sender:self];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scrolView layoutIfNeeded];
    _scrolView.contentSize = _contentView.bounds.size;
    [ self.navigationController.navigationBar setBarTintColor :[ UIColor colorWithRed:0.0 green:0.5 blue:0.2 alpha:1]];
    
    UIImage *leftMenu = [UIImage imageNamed:@"menu"];
    leftMenu = [leftMenu imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:leftMenu style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    MusicIndicator *indicator = [MusicIndicator sharedInstance];
    indicator.hidesWhenStopped = NO;
    indicator.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:indicator];
    
    UITapGestureRecognizer *tapInditator = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapIndicator)];
    tapInditator.numberOfTapsRequired = 1;
    [indicator addGestureRecognizer:tapInditator];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self createIndicatorView];
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
- (void)handleTapIndicator
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    if (musicVC.musicEntities.count == 0)
    {
        [self showMiddleHint:@"Playlist is empty"];
        return;
    }
    musicVC.dontReloadMusic = YES;
    [self presentToMusicViewWithMusicVC:musicVC];
}

- (void)presentToMusicViewWithMusicVC:(MusicViewController *)musicVC
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (void)showMiddleHint:(NSString *)hint
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.labelFont = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.yOffset = 0;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)createIndicatorView
{
    MusicIndicator *indicator = [MusicIndicator sharedInstance];
    indicator.hidesWhenStopped = NO;
    indicator.tintColor = [UIColor whiteColor];
    
    if (indicator.state != NAKPlaybackIndicatorViewStatePlaying)
    {
        indicator.state = NAKPlaybackIndicatorViewStatePlaying;
        indicator.state = NAKPlaybackIndicatorViewStateStopped;
    } else
    {
        indicator.state = NAKPlaybackIndicatorViewStatePlaying;
    }
    
    [self.navigationController.navigationBar addSubview:indicator];
    
    UITapGestureRecognizer *tapInditator = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapIndicator)];
    tapInditator.numberOfTapsRequired = 1;
    [indicator addGestureRecognizer:tapInditator];
}


@end
