#import <UIKit/UIKit.h>

@interface GMCheckmarkView : UIControl

@property (nonatomic, assign) BOOL selected;

-(void) setSelected:(BOOL)selected animated:(BOOL)animated;
@end
