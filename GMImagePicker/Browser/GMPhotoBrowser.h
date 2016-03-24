#import <UIKit/UIKit.h>
#import "GMPhoto.h"

@interface GMPhotoBrowser : UIViewController <UIScrollViewDelegate>
// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
// 保存按钮
@property (nonatomic, assign) BOOL showSaveBtn;
@property (nonatomic, strong) NSMutableOrderedSet *selectedAssets;

@end