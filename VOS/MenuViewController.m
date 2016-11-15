//
//  MenuViewController.m
//  Voice of the street
//
//  Created by Abbey Ola on 08/10/2016.
//  Copyright © 2016 aufree. All rights reserved.
//

#import "MenuViewController.h"
#import "MusicListViewController.h"
#import "LoginViewController.h"
#import "MusicViewController.h"

@interface MenuViewController ()

@end
NSArray *titles;
UITableViewCell *cell;
@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"bnkhjddd");
    //self.view.backgroundColor = [UIColor grayColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 6) / 2.0f, self.view.frame.size.width, 54 * 6) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    [self getUserFBName];
}

-(void) viewDidAppear:(BOOL)animated{
    NSLog(@"mallloiii");
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"musicList"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            [self settitlebar: @"as e dey hot"];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"musicList"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            [self settitlebar: @"top rated"];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"musicList"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            [self settitlebar: @"our pick"];
            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"musicList"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            [self settitlebar: @"my selection"];
            break;
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"aboutUs"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 5:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"fbLogin"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font =[UIFont italicSystemFontOfSize:21.0];
        cell.textLabel.highlightedTextColor = [UIColor blueColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    titles = @[@"As e dey Hot", @"Top Rated", @"Our pick", @"My Selection",@"About", @"Log In"];
    //NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    
    cell.textLabel.text = titles[indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

-(void) getUserFBName
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"already logged in");
        // User is logged in, do work such as go to next view controller.
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, first_name, last_name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
                 NSString *name = [result objectForKey:@"first_name"];
                 NSLog(@"my name: %@", name);
                 titles = @[@"Map", @"#Trending", @"Pictures", @"About",@"Settings", name];
                 cell.textLabel.text = name;
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
    }
    else{
        NSLog(@"no session");
        cell.textLabel.text = @"Log In";
    }
        //titles = @[@"As e dey Hot", @"Top Rated", @"Our pick", @"My Selection",@"About", @"Log In"];
}

-(void) settitlebar:(NSString *)title
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = title;
}
@end
