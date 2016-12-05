#import "MusicListViewController.h"
#import "MusicViewController.h"
#import "MusicListCell.h"
#import "MusicIndicator.h"
#import "MBProgressHUD.h"
#import "MenuViewController.h"

@interface MusicListViewController () <MusicViewControllerDelegate, MusicListCellDelegate, UISearchDisplayDelegate>
@property (nonatomic, strong) NSMutableArray *musicEntities;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *searchResult;
@property (nonatomic, strong) NSMutableArray *musicArray;
@property (nonatomic, strong) MusicEntity *music;
@end
int indexWatcher;
BOOL showdeletebotton;
BOOL containdata;
//UIRefreshControl *refreshController;
@implementation MusicListViewController

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"artistName contains[c] %@ OR name contains[c] %@", searchText, searchText];
    _searchResult = [_musicEntities filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [controller.searchResultsTableView setBackgroundColor:[UIColor colorWithRed:0.07 green:0.15 blue:0.02 alpha:1.0]];
    [controller.searchResultsTableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];

    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];

    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _searchBar.backgroundColor = [UIColor redColor];
    
     MusicViewController *musicVC = [MusicViewController sharedInstance];
    
    [self getofflinelist];
    [self enablepulltorefresh];
    
    [ self.navigationController.navigationBar setBarTintColor :[ UIColor colorWithRed:0.0 green:0.5 blue:0.2 alpha:1]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorColor = [UIColor clearColor];
    self.navigationItem.title = musicVC.musicTitle;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self headerRefreshing];
}

-(void)getofflinelist
{
    if (!_musicEntitiesSelection) _musicEntitiesSelection = [[NSMutableArray alloc] init];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"mySelection"];
    if (data)
    {
        _musicEntitiesSelection = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

-(void)enablepulltorefresh
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.0 green:0.5 blue:0.2 alpha:1];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(pullToRefresh:)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self createIndicatorView];
}

# pragma mark - Custom right bar button item

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

# pragma mark - Load data from server

- (void)headerRefreshing
{
    MusicViewController *musicVC = [MusicViewController sharedInstance];
    if ([musicVC.musicTitle isEqualToString:@"my selection"])
    {
        _musicEntities = _musicEntitiesSelection;
        showdeletebotton = true;
        [self.tableView reloadData];
        if (_musicEntitiesSelection.count != 0)
        {
            self.tableView.backgroundView = nil;
        }
        else
        {
            [self tableviewbackgroundtext:@"Its boring here, you have not added any track to your selection"];
        }
        
    }
    else if ([musicVC.musicTitle isEqualToString:@"as e dey hot"])
    {
        showdeletebotton = false;
        [self loadjsondata:@"http://9jacarwash.com/trending.json"];
        [self checkforemptytable];
    }
    else if ([musicVC.musicTitle isEqualToString:@"dj mix"])
    {
        showdeletebotton = false;
        [self loadjsondata:@"http://9jacarwash.com/dj_mix.json"];
        [self checkforemptytable];
    }
    else if ([musicVC.musicTitle isEqualToString:@"next rated"])
    {
        showdeletebotton = false;
        [self loadjsondata:@"http://9jacarwash.com/newbies.json"];
        [self checkforemptytable];
    }
    else if ([musicVC.musicTitle isEqualToString:@"ybnl nation"])
    {
        showdeletebotton = false;
        [self loadjsondata:@"http://9jacarwash.com/ybnl.json"];
        [self checkforemptytable];
    }
    else if ([musicVC.musicTitle isEqualToString:@"maven"])
    {
        showdeletebotton = false;
        [self loadjsondata:@"http://9jacarwash.com/maven.json"];
        [self checkforemptytable];
    }
    else if ([musicVC.musicTitle isEqualToString:@"old school"])
    {
        showdeletebotton = false;
        [self loadjsondata:@"http://9jacarwash.com/old_school.json"];
        [self checkforemptytable];
    }
    else if ([musicVC.musicTitle isEqualToString:@"gospel"])
    {
        showdeletebotton = false;
        [self loadjsondata:@"http://9jacarwash.com/gospel.json"];
        [self checkforemptytable];
    }
    
    [self.tableView reloadData];
}

-(void)pullToRefresh : (id)sender
{
    [self headerRefreshing];
    [self.refreshControl endRefreshing];
}

-(void)loadjsondata:(NSString *)jsonurl
{
    NSURL *url = [NSURL URLWithString:jsonurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *musicsDict = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0
                                                                          error:NULL];
             _musicEntities = [MusicEntity arrayOfEntitiesFromArray:musicsDict[@"data"]].mutableCopy;
             _searchResult = [NSMutableArray arrayWithCapacity:[_musicEntities count]];
             self.tableView.backgroundView = nil;
             [self.tableView reloadData];
         }
     }];
}

- (NSDictionary *)dictionaryWithContentsOfJSONString:(NSString *)fileLocation
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

# pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(playMusicWithSpecialIndex:)])
    {
        [_delegate playMusicWithSpecialIndex:indexPath.row];
    }
    else
    {
        MusicViewController *musicVC = [MusicViewController sharedInstance];
        musicVC.musicTitle = self.navigationItem.title;
        if (indexWatcher == 1) {
            musicVC.musicEntities = [_searchResult mutableCopy];
        }
        else
        {
           musicVC.musicEntities = _musicEntities;
        }
        musicVC.specialIndex = indexPath.row;
        
        musicVC.delegate = self;
        [self presentToMusicViewWithMusicVC:musicVC];
    }
    [self updatePlaybackIndicatorWithIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - Jump to music view

- (void)presentToMusicViewWithMusicVC:(MusicViewController *)musicVC
{
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

# pragma mark - Update music indicator state

- (void)updatePlaybackIndicatorWithIndexPath:(NSIndexPath *)indexPath
{
    for (MusicListCell *cell in self.tableView.visibleCells)
    {
        cell.state = NAKPlaybackIndicatorViewStateStopped;
    }
    MusicListCell *musicsCell = [self.tableView cellForRowAtIndexPath:indexPath];
    musicsCell.state = NAKPlaybackIndicatorViewStatePlaying;
}

- (void)updatePlaybackIndicatorOfCell:(MusicListCell *)cell
{
    MusicEntity *music = cell.musicEntity;
    if (music.musicId == [[MusicViewController sharedInstance] currentPlayingMusic].musicId)
    {
        cell.state = NAKPlaybackIndicatorViewStateStopped;
        cell.state = [MusicIndicator sharedInstance].state;
    } else
    {
        cell.state = NAKPlaybackIndicatorViewStateStopped;
    }
}

- (void)updatePlaybackIndicatorOfVisisbleCells
{
    for (MusicListCell *cell in self.tableView.visibleCells)
    {
        [self updatePlaybackIndicatorOfCell:cell];
    }
}

# pragma mark - Tableview datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [_searchResult count];
    }
    else
    {
        return [_musicEntities count];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_musicEntities.count != 0)
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    }
    else if (_musicEntities.count == 0)
    {
        MusicViewController *musicVC = [MusicViewController sharedInstance];
        
        if ([musicVC.musicTitle isEqualToString:@"my selection"])
        {
            [self tableviewbackgroundtext:@"Its boring here, you have not added any track to your selection, go heart some music and they will be available to you offline"];
        }
        else
        {
            [self tableviewbackgroundtext:@"This content is empty, please try again later"];
        }
    }
    return 0;
}

-(void)tableviewbackgroundtext: (NSString*)text
{
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    messageLabel.text = text;
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    messageLabel.textColor = [UIColor whiteColor];
    [messageLabel sizeToFit];
    self.tableView.backgroundView = messageLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *musicListCell = @"musicListCell";
    MusicListCell *cell = (MusicListCell*)[self.tableView dequeueReusableCellWithIdentifier:musicListCell];
    if (cell == nil)
    {
        cell = [[MusicListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:musicListCell];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        _music = _searchResult[indexPath.row];
        indexWatcher = 1;
    }
    else
    {
        //MusicViewController *musicVC = [MusicViewController sharedInstance];
        for (MusicEntity *musicEntityinqueue in _musicEntitiesSelection)
        {
            if ([[_musicEntities[indexPath.row] musicUrl] isEqualToString:musicEntityinqueue.musicUrl])
            {
                [_musicEntities[indexPath.row] setIsFavorited:true];
            }
        }
        _music = _musicEntities[indexPath.row];

    }
    cell.musicNumber = indexPath.row + 1;
    cell.musicEntity = _music;
    cell.delegate = self;
    if (!showdeletebotton) cell.deletetrack.hidden = true;
    else
        cell.deletetrack.hidden = false;
    
    [self updatePlaybackIndicatorOfCell:cell];
    
    return cell;
}

# pragma mark - HUD
         
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

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    indexWatcher = 0;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchController *)controller
{
    indexWatcher = 0;
}
- (IBAction)deletethistrack:(id)sender
{

    MusicEntity *trackTodelete = [_musicEntities objectAtIndex:[sender tag]];
    [self deletefilefromSelection:trackTodelete.fileName :(int)[sender tag]];}

-(void)deletefilefromSelection:(NSString *)filename :(int)index
{
    [_musicEntitiesSelection removeObjectAtIndex:index];
    //_musicEntities = _musicEntitiesSelection;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [self savemusicentitytodisk];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filewithsufix = [NSString stringWithFormat:@"%@.mp3", filename];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:filewithsufix];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success)
    {
       [self showMiddleHint:@"track deleted"];
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

-(void)savemusicentitytodisk
{
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:_musicEntitiesSelection];
    [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:@"mySelection"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

-(void)checkforemptytable
{
    if (_musicEntities)
    {
        self.tableView.backgroundView = nil;
    }
    else
    {
        [self tableviewbackgroundtext:@"This content is empty, please try again later"];
    }
}

@end
