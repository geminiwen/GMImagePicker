#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <Photos/Photos.h>

@interface GMPhoto : NSObject
@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, assign) int index; // 索引

@end