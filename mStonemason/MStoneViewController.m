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
@property (nonatomic, assign) BOOL flipRed;

@property (nonatomic, strong) id<MASConstraint> greenConstraint;
@property (nonatomic, assign) BOOL flipGreen;
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
  
  id boxSize = @(50.f);
  
  [redBox mas_makeConstraints:^(MASConstraintMaker *make) {
    self.redConstraint = make.top.equalTo(superview.mas_top).with.offset(kInset);
    make.left.equalTo(superview.mas_left).with.offset(kInset);
    make.size.equalTo(boxSize);
  }];
  
  [greenBox mas_makeConstraints:^(MASConstraintMaker *make) {
    self.greenConstraint =  make.top.equalTo(superview.mas_top).with.offset(kInset);
    make.left.equalTo(redBox.mas_right).with.offset(10.f);
    make.size.equalTo(boxSize);
  }];
  
  [blueBox mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.mas_top).with.offset(kInset);
    make.right.equalTo(superview.mas_right).with.offset(-kInset);
    make.size.equalTo(boxSize);
  }];
  
  [self addButtons];
}

- (void)addButtons
{
  UIView *superview = self.view;
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"red" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(moveRed) forControlEvents:UIControlEventTouchUpInside];
  [superview addSubview:button];
  
  [button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview.mas_centerX).offset(-50.f);
    make.centerY.equalTo(superview.mas_centerY);
  }];
  
  button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button setTitle:@"green" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(moveGreen) forControlEvents:UIControlEventTouchUpInside];
  [superview addSubview:button];
  
  [button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(superview.mas_centerX).offset(50.f);
    make.centerY.equalTo(superview.mas_centerY);
  }];
}

- (void)moveRed
{
  UIView *superview = self.view;
  
  [self.redConstraint uninstall];
  
  [self.redBox mas_makeConstraints:^(MASConstraintMaker *make) {
    self.redConstraint = (self.flipRed)
    ? make.top.equalTo(superview.mas_top).with.offset(kInset)
    : make.bottom.equalTo(superview.mas_bottom).with.offset(-kInset);
  }];
  
  self.flipRed = !self.flipRed;
  
  [UIView animateWithDuration:.3f animations:^{
    [self updateViewConstraints];
    [self.view layoutIfNeeded];
  }];
}

- (void)moveGreen
{
  CGFloat inset = (self.flipGreen) ? kInset : kInset + 50.f;
  self.greenConstraint.offset(inset);
  
  self.flipGreen = !self.flipGreen;
  
  [UIView animateWithDuration:.3f animations:^{
    [self updateViewConstraints];
    [self.view layoutIfNeeded];
  }];
}


@end

