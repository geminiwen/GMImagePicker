#import "GMPhotoBrowser.h"
#import "GMPhoto.h"
#import "GMPhotoView.h"
#import "GMPhotoToolbar.h"
#import "GMCheckmarkView.h"

#define kPadding 10
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)

@interface GMPhotoBrowser () <GMPhotoViewDelegate>
@property (strong, nonatomic) UIScrollView *photoScrollView;
@property (strong, nonatomic) NSMutableSet *visiblePhotoViews, *reusablePhotoViews;
@property (strong, nonatomic) GMPhotoToolbar *toolbar;
@property (strong, nonatomic) UIBarButtonItem *rightButton;
@property (strong, nonatomic) GMCheckmarkView *checkMarkView;
@end

@implementation GMPhotoBrowser


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setToolbarHidden:YES];
    
    self.showSaveBtn = YES;
    if (!_visiblePhotoViews) {
        _visiblePhotoViews = [NSMutableSet set];
    }
    if (!_reusablePhotoViews) {
        _reusablePhotoViews = [NSMutableSet set];
    }
    self.toolbar.photos = self.photos;
    
    
    CGRect frame = self.view.bounds;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
    self.photoScrollView.contentSize = CGSizeMake(frame.size.width * self.photos.count, 0);
    self.photoScrollView.contentOffset = CGPointMake(self.currentPhotoIndex * frame.size.width, 0);
    
    [self.view addSubview:self.photoScrollView];
    [self.view addSubview:self.toolbar];
    [self setupNavigationItem];
    [self updateToolbarState];
    [self updateNavigationBarState];
    [self showPhotos];
}

- (void) setupNavigationItem {
    self.checkMarkView = [[GMCheckmarkView alloc] initWithFrame:CGRectMake(0, 0, 29, 29)];
    [self.checkMarkView addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = [[UIBarButtonItem alloc] initWithCustomView:self.checkMarkView];
    self.navigationItem.rightBarButtonItem = self.rightButton;
}

- (UIScrollView *)photoScrollView{
    if (!_photoScrollView) {
        CGRect frame = self.view.bounds;
        frame.origin.x -= kPadding;
        frame.size.width += (2 * kPadding);
        _photoScrollView = [[UIScrollView alloc] initWithFrame:frame];
        _photoScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _photoScrollView.pagingEnabled = YES;
        _photoScrollView.delegate = self;
        _photoScrollView.showsHorizontalScrollIndicator = NO;
        _photoScrollView.showsVerticalScrollIndicator = NO;
        _photoScrollView.backgroundColor = [UIColor clearColor];
    }
    return _photoScrollView;
}

- (GMPhotoToolbar *)toolbar{
    if (!_toolbar) {
        CGFloat barHeight = 49;
        CGFloat barY = self.view.frame.size.height - barHeight;
        _toolbar = [[GMPhotoToolbar alloc] init];
        _toolbar.frame = CGRectMake(0, barY, self.view.frame.size.width, barHeight);
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    return _toolbar;
}

#pragma mark - set M
- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    if (_photos.count <= 0) {
        return;
    }
    for (int i = 0; i<_photos.count; i++) {
        GMPhoto *photo = _photos[i];
        photo.index = i;
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    if (_photoScrollView) {
        _photoScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photoScrollView.frame.size.width, 0);
        
        // 显示所有的相片
        [self showPhotos];
    }
}

#pragma mark - Show Photos
- (void)showPhotos
{
    CGRect visibleBounds = _photoScrollView.bounds;
    int firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
    int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= _photos.count) firstIndex = (int)_photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= _photos.count) lastIndex = (int)_photos.count - 1;
    
    // 回收不再显示的ImageView
    NSInteger photoViewIndex;
    for (GMPhotoView *photoView in _visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
        if (photoViewIndex < firstIndex || photoViewIndex > lastIndex) {
            [_reusablePhotoViews addObject:photoView];
            [photoView removeFromSuperview];
        }
    }
    
    [_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
    
    for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
        if (![self isShowingPhotoViewAtIndex:index]) {
            [self showPhotoViewAtIndex:(int)index];
        }
    }
    
}

//  显示一个图片view
- (void)showPhotoViewAtIndex:(int)index
{
    GMPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[GMPhotoView alloc] init];
        photoView.photoViewDelegate = self;
    }
    
    // 调整当前页的frame
    CGRect bounds = _photoScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    GMPhoto *photo = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.photo = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photoScrollView addSubview:photoView];
    
}

//  index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
    for (GMPhotoView *photoView in _visiblePhotoViews) {
        if (kPhotoViewIndex(photoView) == index) {
            return YES;
        }
    }
    return  NO;
}
// 重用页面
- (GMPhotoView *)dequeueReusablePhotoView
{
    GMPhotoView *photoView = [_reusablePhotoViews anyObject];
    if (photoView) {
        [_reusablePhotoViews removeObject:photoView];
    }
    return photoView;
}

#pragma mark - updateTollbarState
- (void)updateToolbarState
{
    _currentPhotoIndex = self.photoScrollView.contentOffset.x / self.photoScrollView.frame.size.width;
    self.toolbar.currentPhotoIndex = _currentPhotoIndex;
}

- (void) updateNavigationBarState {
    GMPhoto* photo = self.photos[_currentPhotoIndex];
    if ([self.imagePickerController.selectedAssets containsObject:photo.asset]) {
        [self.checkMarkView setSelected:YES];
    } else {
        [self.checkMarkView setSelected:NO];
    }
}

#pragma mark - MJPhotoViewDelegate
- (void)photoViewSingleTap:(GMPhotoView *)photoView
{
    if (self.navigationController.navigationBar.hidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
}

- (void)photoViewImageFinishLoad:(GMPhotoView *)photoView
{
    [self updateToolbarState];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self showPhotos];
    [self updateToolbarState];
    [self updateNavigationBarState];
}

- (void) selectPhoto {
    GMPhoto* photo = self.photos[_currentPhotoIndex];
    PHAsset* asset = photo.asset;
    GMImagePickerController *imagePickerController = self.imagePickerController;
    if (self.imagePickerController.allowsMultipleSelection) {
         NSMutableOrderedSet *selectedAssets = self.imagePickerController.selectedAssets;
        if ([selectedAssets containsObject:asset]) {
            [selectedAssets removeObject:asset];
            [self.checkMarkView setSelected:NO];
        } else {
            [selectedAssets addObject:asset];
            [self.checkMarkView setSelected:YES animated:YES];
            
        }
    } else {
        if ([imagePickerController.delegate respondsToSelector:@selector(gm_imagePickerController:didFinishPickingAssets:)]) {
            [imagePickerController.delegate gm_imagePickerController:imagePickerController didFinishPickingAssets:@[asset]];
        }
    }
    
    if ([imagePickerController.delegate respondsToSelector:@selector(gm_imagePickerController:didSelectAsset:)]) {
        [imagePickerController.delegate gm_imagePickerController:imagePickerController didSelectAsset:asset];
    }
}


@end