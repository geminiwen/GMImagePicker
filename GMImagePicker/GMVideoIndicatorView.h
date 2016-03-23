//
//  QBVideoIndicatorView.h
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/04.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GMVideoIconView.h"
#import "GMSlomoIconView.h"

@interface GMVideoIndicatorView : UIView

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet GMVideoIconView *videoIcon;
@property (nonatomic, weak) IBOutlet GMSlomoIconView *slomoIcon;


@end
