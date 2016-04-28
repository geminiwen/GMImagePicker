#import "GMCheckmarkView.h"
#import "POP.h"

@interface GMCheckmarkView()
@property (strong, nonatomic) UIImageView *checkmark;
@end

@implementation GMCheckmarkView

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void) initialize {
    CGRect rootB = self.bounds;
    CGFloat checkmarkWH = 29;
    CGFloat checkmarkX = (CGRectGetWidth(rootB) - checkmarkWH) / 2.0;
    CGFloat checkmarkY = 0;
    self.checkmark = [[UIImageView alloc] initWithFrame:
                      CGRectMake(checkmarkX, checkmarkY, checkmarkWH, checkmarkWH)];
    [self addSubview:self.checkmark];
    [self.checkmark setImage:[UIImage imageNamed:@"check"]];
}

-(void) layoutSubviews {
    [super layoutSubviews];
   
}

- (void) setSelected:(BOOL)selected animated:(BOOL)animated {
    [self setSelected:selected];
    if (!animated) {
        return;
    }
    if (selected) {
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.8, 0.8)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        anim.springBounciness = 20.0f;
        anim.springSpeed = 20.0f;
        [self.checkmark.layer pop_addAnimation:anim forKey:@"scale"];
    }
}

- (void) setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self.checkmark setImage:[UIImage imageNamed:@"checked"]];
    } else {
        [self.checkmark setImage:[UIImage imageNamed:@"check"]];
    }
}

- (BOOL) isSelected {
    return [super isSelected];
}

@end
