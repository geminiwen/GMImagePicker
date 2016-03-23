//
//  QBAssetCell.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "GMAssetCell.h"
#import "GMCheckmarkView.h"
@interface GMAssetCell ()

@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet GMCheckmarkView *checkmark;

@end

@implementation GMAssetCell

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    self.checkmark.selected = selected;
    // Show/hide overlay view
//    self.overlayView.hidden = !(selected && self.showsOverlayViewWhenSelected);
}

@end
