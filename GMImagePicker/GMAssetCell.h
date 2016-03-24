#import <UIKit/UIKit.h>
#import "GMCheckmarkView.h"

@interface GMAssetCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet GMCheckmarkView *checkmark;

@property (copy, nonatomic) void (^selectBlock) (GMAssetCell *cell);

@end
