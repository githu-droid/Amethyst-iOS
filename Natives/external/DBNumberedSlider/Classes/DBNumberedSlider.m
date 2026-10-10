#import "DBNumberedSlider.h"

@interface DBNumberedSlider ()
@property(nonatomic, strong) UILabel *bubble;
@end

@implementation DBNumberedSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.clipsToBounds = NO;

    self.bubble = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 24)];
    self.bubble.textAlignment = NSTextAlignmentCenter;
    self.bubble.font = [UIFont monospacedDigitSystemFontOfSize:14 weight:UIFontWeightMedium];
    self.bubble.textColor = UIColor.whiteColor;
    self.bubble.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.75];
    self.bubble.layer.cornerRadius = 6;
    self.bubble.layer.masksToBounds = YES;
    self.bubble.userInteractionEnabled = NO;
    self.bubble.hidden = YES;
    [self addSubview:self.bubble];

    [self addTarget:self action:@selector(db_valueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)db_updateBubble {
    self.bubble.text = [NSString stringWithFormat:@"%ld", (long)lroundf(self.value)];

    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbRect = [self thumbRectForBounds:self.bounds trackRect:trackRect value:self.value];
    CGSize size = [self.bubble sizeThatFits:CGSizeMake(200, 24)];
    size.width = MAX(size.width + 14, 36);
    size.height = 24;
    self.bubble.bounds = CGRectMake(0, 0, size.width, size.height);
    self.bubble.center = CGPointMake(CGRectGetMidX(thumbRect), CGRectGetMinY(thumbRect) - size.height / 2 - 2);
}

- (void)db_valueChanged {
    if (!self.bubble.hidden) {
        [self db_updateBubble];
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    BOOL result = [super beginTrackingWithTouch:touch withEvent:event];
    if (result) {
        [self db_updateBubble];
        self.bubble.hidden = NO;
    }
    return result;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    self.bubble.hidden = YES;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    self.bubble.hidden = YES;
}

@end
