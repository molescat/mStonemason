//
//  Copyright (c) 2013 Myles Abbott. All rights reserved.
//

#import "UIView+MStoneMASAddition.h"
#import "Masonry.h"

@implementation UIView (MStoneMASAddition)

- (MASLayoutConstraint *)constraintWithKey:(NSString *)key
{
  for (NSLayoutConstraint *constraint in self.constraints)
  {
    MASLayoutConstraint *masConstraint = (MASLayoutConstraint *)constraint;
    if ([masConstraint respondsToSelector:@selector(mas_key)]
        && [masConstraint mas_key])
    {
      if ([key isEqualToString:masConstraint.mas_key])
      {
        return masConstraint;
      }
    }
  }
  return nil;
}

@end
