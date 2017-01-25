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
#import "MusicCategoryViewController.h"

@interface MenuViewController ()


@end
NSArray *titles;
UITableViewCell *cell;
@implementation MenuViewController
UILabel *label;
UILabel *labelout;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 3) / 2.0f, self.view.frame.size.width, 54 * 3) style:UITableViewStylePlain];
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

-(void)viewDidAppear:(BOOL)animated
{
    _greeting.text = @"";
    label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 19, 10)];
    label.text = @"";
    label.frame = _greeting.frame;
    label.font = _greeting.font;
    label.textColor = _greeting.textColor;
    [self.view addSubview:label];
    
    labelout = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 19, 10)];
    labelout.text = @"  You are not signed in";
    labelout.frame = _greeting.frame;
    labelout.font = _greeting.font;
    labelout.textColor = _greeting.textColor;
    [self.view addSubview:labelout];
    
    labelout.hidden = true;
    label.hidden = true;

}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"mcategory"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"aboutUs"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"fbLogin"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font =[UIFont italicSystemFontOfSize:21.0];
        cell.textLabel.highlightedTextColor = [UIColor blueColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    titles = @[@"Home", @"About", @"Log in"];
    NSArray *images = @[@"home", @"about", @"login"];
    
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

-(void) getUserFBName
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, first_name, last_name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSString *name = [result objectForKey:@"first_name"];
                 titles = @[@"Home", @"About", @"Log out"];
                 labelout.hidden = true;
                 label.hidden = false;
                 label.text = [NSString stringWithFormat:@"  What's up %@ ?", name];
                 cell.textLabel.text = @"Log out";
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
    }
    else
    {
        label.text = @"";
        label.hidden = true;
        labelout.hidden = false;
        cell.textLabel.text = @"Log In";
    }
}

-(void) settitlebar:(NSString *)title
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    musicVC.musicTitle = title;
}
@end
