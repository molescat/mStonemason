//
//  Copyright (c) 2013 Myles Abbott. All rights reserved.
//

#import "MStoneAppDelegate.h"
#import <dlfcn.h>

@implementation MStoneAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [self startReveal];
  return YES;
}
							
#pragma mark - Reveal

- (void)startReveal
{
  NSString *revealLibName = @"libReveal";
  NSString *revealLibExtension = @"dylib";
  NSString *dyLibPath = [[NSBundle mainBundle] pathForResource:revealLibName ofType:revealLibExtension];
  NSLog(@"Loading dynamic library: %@", dyLibPath);
  
  void *revealLib = NULL;
  revealLib = dlopen([dyLibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
  
  if (revealLib == NULL)
  {
    char *error = dlerror();
    NSLog(@"dlopen error: %s", error);
    NSString *message = [NSString stringWithFormat:@"%@.%@ failed to load with error: %s", revealLibName, revealLibExtension, error];
    [[[UIAlertView alloc] initWithTitle:@"Reveal library could not be loaded" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  }
  else
  {
    // Post a notification to signal Reveal to start the service.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:self];
  }
}

@end
