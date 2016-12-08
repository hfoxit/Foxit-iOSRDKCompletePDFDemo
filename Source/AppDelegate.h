/**
 * Copyright (C) 2003-2016, Foxit Software Inc..
 * All Rights Reserved.
 *
 * http://www.foxitsoftware.com
 *
 * The following code is copyrighted and is the proprietary of Foxit Software Inc.. It is not allowed to 
 * distribute any parts of Foxit Mobile PDF SDK to third party or public without permission unless an agreement 
 * is signed between Foxit Software Inc. and customers to explicitly grant customers permissions.
 * Review legal.txt for additional license and legal information.

 */
#import <UIKit/UIKit.h>
#import <FoxitRDK/FSPDFObjC.h>
#import <FoxitRDK/FSPDFViewControl.h>

#import "ReadFrame.h"
#import "UIExtensionsSharedHeader.h"
#import "Defines.h"

#define DEMO_APPDELEGATE  ((AppDelegate*)[[UIApplication sharedApplication] delegate])

@class UIExtensionsManager;
@class App;
@class ReadFrame;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) FSPDFViewCtrl* pdfViewCtrl;

@property (nonatomic, strong) App* app;
@property (nonatomic, strong) ReadFrame* readFrame;

@property (nonatomic, assign) BOOL isFileEdited;
@property (nonatomic, copy) NSString* filePath;

@property (nonatomic, assign) BOOL isScreenLocked;

- (BOOL)openPDFAtPath:(NSString*)path withPassword:(NSString*)password;

@end
