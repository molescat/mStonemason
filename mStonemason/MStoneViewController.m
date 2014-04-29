//
//  Copyright (c) 2013 Myles Abbott. All rights reserved.
//

#import "MStoneViewController.h"
#import "UIView+MStoneMASAddition.h"
#import "Masonry.h"

@interface MStoneViewController ()
@property (nonatomic, strong) UIView *redBox;
@property (nonatomic, strong) MASConstraint *redConstraint;
@property (nonatomic, assign) BOOL flipRed;
@property (nonatomic, assign) BOOL flipGreen;
@end

@implementation MStoneViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIView *superview = self.view;
  
  UIView *redBox = [[UIView alloc] initWithFrame:CGRectZero];
  redBox.backgroundColor = [UIColor redColor];
  [superview addSubview:redBox];
  self.redBox = redBox;
  
  UIView *greenBox = [[UIView alloc] initWithFrame:CGRectZero];
  greenBox.backgroundColor = [UIColor greenColor];
  [superview addSubview:greenBox];
  
  UIView *blueBox = [[UIView alloc] initWithFrame:CGRectZero];
  blueBox.backgroundColor = [UIColor cyanColor];
  [superview addSubview:blueBox];
  
  UIView *topGuide = (UIView *)self.topLayoutGuide; // iOS7
  id boxSize = @(50.f);
  
  [redBox mas_makeConstraints:^(MASConstraintMaker *make) {
    self.redConstraint = make.top.equalTo(topGuide.mas_bottom);
    make.left.equalTo(superview.mas_left).with.offset(20.f);
    make.size.equalTo(boxSize);
  }];
  
  [greenBox mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(topGuide.mas_bottom).key(@"greenBox");
    make.centerX.equalTo(superview.mas_centerX);
    make.size.equalTo(boxSize);
  }];
  
  [blueBox mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(topGuide.mas_bottom);
    // make.top.equalTo(redBox.mas_top);  // Relative to RedBox animation example
    make.right.equalTo(superview.mas_right).with.offset(-20.f);
    make.size.equalTo(boxSize);
  }];
  
  [self addButtons];
}

- (void)addButtons
{
  UIView *superview = self.view;
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"red" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(moveRedByRemoveInstallConstraint) forControlEvents:UIControlEventTouchUpInside];
  [superview addSubview:button];
  
  [button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview.mas_centerX).offset(-50.f);
    make.centerY.equalTo(superview.mas_centerY);
  }];
  
  button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"green" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(moveGreenByChangingContraintConstant) forControlEvents:UIControlEventTouchUpInside];
  [superview addSubview:button];
  
  [button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview.mas_centerX).offset(50.f);
    make.centerY.equalTo(superview.mas_centerY);
  }];
}

- (void)moveRedByRemoveInstallConstraint
{
  UIView *superview = self.view;
  
  [self.redConstraint uninstall];
  
  [self.redBox mas_makeConstraints:^(MASConstraintMaker *make) {
    CGFloat topBarOffset = self.topLayoutGuide.length;

    self.redConstraint = (self.flipRed)
      ? make.top.equalTo(superview.mas_top).with.offset(topBarOffset)
      : make.bottom.equalTo(superview.mas_bottom).with.offset(-topBarOffset);
  }];
  
  self.flipRed = !self.flipRed;
  
  [UIView animateWithDuration:.3f animations:^{
    [self.view layoutIfNeeded];
  }];
}

- (void)moveGreenByChangingContraintConstant
{
  CGFloat inset = (self.flipGreen) ? 0.f : 50.f;
  
  [self.view constraintWithKey:@"greenBox"].constant = inset;
  
  self.flipGreen = !self.flipGreen;
  
  [UIView animateWithDuration:.3f animations:^{
    [self.view layoutIfNeeded];
  }];
}

@end
