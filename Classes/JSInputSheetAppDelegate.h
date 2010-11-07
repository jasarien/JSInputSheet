//
//  JSInputSheetAppDelegate.h
//  JSInputSheet
//
//  Created by James on 07/11/2010.
//  Copyright 2010 JamSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSInputSheetViewController;

@interface JSInputSheetAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    JSInputSheetViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet JSInputSheetViewController *viewController;

@end

