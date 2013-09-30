//
//  MStoneViewController.m
//  mStonemason
//
//  Created by Myles Abbott on 30/09/13.
//  Copyright (c) 2013 Myles Abbott. All rights reserved.
//

#import "MStoneViewController.h"

#import "Masonry.h"

@interface MStoneViewController ()
@property (nonatomic, strong) UIView *redBox;
@property (nonatomic, strong) id<MASConstraint> redConstraint;
@property (nonatomic, assign) BOOL flipSwitch;
@end

@implementation MStoneViewController

static const CGFloat kInset = 20.f;

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
  blueBox.backgroundColor = [UIColor blueColor];
  [superview addSubview:blueBox];
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"move" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(changeConstraints) forControlEvents:UIControlEventTouchUpInside];
  [superview addSubview:button];
  
  id boxHeight = @(50.f);
  id boxWidth = @(50.f);
  
  [redBox mas_makeConstraints:^(MASConstraintMaker *make) {
    self.redConstraint = make.top.equalTo(superview.mas_top).with.offset(kInset);
    make.left.equalTo(superview.mas_left).with.offset(kInset);
    make.width.equalTo(boxWidth);
    make.height.equalTo(boxHeight);
  }];
  
  [greenBox mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_top).with.offset(kInset);
    make.left.equalTo(redBox.mas_right).with.offset(10.f);
    make.width.equalTo(boxWidth);
    make.height.equalTo(boxHeight);
  }];
  
  [blueBox mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_top).with.offset(kInset);
    make.right.equalTo(superview.mas_right).with.offset(-kInset);
    make.width.equalTo(boxWidth);
    make.height.equalTo(boxHeight);
  }];
  
  [button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview.mas_centerX);
    make.centerY.equalTo(superview.mas_centerY);
  }];
}

- (void)changeConstraints
{
  UIView *superview = self.view;
  
  [self.redConstraint uninstall];
  [self.redBox mas_makeConstraints:^(MASConstraintMaker *make) {
    self.redConstraint = (self.flipSwitch)
    ? make.top.equalTo(superview.mas_top).with.offset(kInset)
    : make.bottom.equalTo(superview.mas_bottom).with.offset(-kInset);
  }];
  
  self.flipSwitch = !self.flipSwitch;
  
  [UIView animateWithDuration:.3f animations:^{
    [self updateViewConstraints];
    [self.view layoutIfNeeded];
  }];
}

@end

