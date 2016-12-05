//
//  LoginViewController.m
//  safeRoad
//
//  Created by Abbey Ola on 30/09/2016.
//  Copyright © 2016 Abbey Ola. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [ self.navigationController.navigationBar setBarTintColor :[ UIColor colorWithRed:0.0 green:0.5 blue:0.2 alpha:1]];
    
    UIImage *leftMenu = [UIImage imageNamed:@"menu"];
    leftMenu = [leftMenu imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithImage:leftMenu style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    
    loginButton.center = CGPointMake(self.view.center.x, self.view.center.y + 200);
    [self.view addSubview:loginButton];
    
    FBSDKLikeControl *likebutton = [[FBSDKLikeControl alloc] init];
    likebutton.objectID = @"https://www.facebook.com/31bridge/";
    likebutton.center = CGPointMake(240/2, 280);
    [self.view addSubview:likebutton];
}

- (void)buttonPressed:(UIButton *)button
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
}

@end
