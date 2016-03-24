#import "GMAssetCell.h"

@interface GMAssetCell ()
@end

@implementation GMAssetCell

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
}

- (IBAction) checkmarkTouchUpInside {
    if (self.selectBlock) {
        self.selectBlock(self);
    }
}



@end
