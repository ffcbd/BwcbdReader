//
//  CBDAppDelegate.h
//  CBD_book
//
//  Created by Federico Frappi on 04/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CBDViewController;
@class registerViewController;

@interface CBDAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    registerViewController *regViewController;
    CBDViewController *detailViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CBDViewController *detailViewController;
@property (nonatomic,strong) IBOutlet registerViewController *regViewController;
@end
