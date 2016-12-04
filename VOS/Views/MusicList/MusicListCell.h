#import <UIKit/UIKit.h>
#import "MusicEntity.h"
#import "NAKPlaybackIndicatorView.h"

@protocol MusicListCellDelegate <NSObject>
@optional
- (void)jumpToMusicListVCWithCurrentIndex:(NSInteger)index;
@end

@interface MusicListCell : UITableViewCell
@property (nonatomic, assign) NSInteger musicNumber;
@property (nonatomic, strong) MusicEntity *musicEntity;
@property (nonatomic, weak) id<MusicListCellDelegate> delegate;
@property (nonatomic, assign) NAKPlaybackIndicatorViewState state;
@property (weak, nonatomic) IBOutlet UIButton *deletetrack;
@end
