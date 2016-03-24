#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class GMPhotoBrowser, GMPhoto, GMPhotoView;

@protocol GMPhotoViewDelegate <NSObject>
- (void)photoViewImageFinishLoad:(GMPhotoView *)photoView;
- (void)photoViewSingleTap:(GMPhotoView *)photoView;
@end

@interface GMPhotoView : UIScrollView <UIScrollViewDelegate>
// 图片
@property (nonatomic, strong) GMPhoto *photo;
// 代理
@property (nonatomic, strong) id<GMPhotoViewDelegate> photoViewDelegate;

@end