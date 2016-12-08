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
#import "ViewController.h"
#import "AppDelegate.h"
#import "DocumentModule.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navController = [[[UINavigationController alloc] init] autorelease];
    self.navController.navigationBarHidden = YES;
    self.navController.view.frame = [[UIScreen mainScreen] bounds];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    UIViewController* fileListViewController = [[[UIViewController alloc] init] autorelease];
    DocumentModule* docModule = [[[DocumentModule alloc] init] autorelease];
    [fileListViewController.view addSubview:[docModule getTopToolbar]];
    [fileListViewController.view addSubview:[docModule getContentView]];
    [self.navController pushViewController:fileListViewController animated:NO];
    [self addChildViewController:self.navController];
    [self.view addSubview:self.navController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - rotate event

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return !DEMO_APPDELEGATE.isScreenLocked;
}

- (BOOL)shouldAutorotate
{
    return !DEMO_APPDELEGATE.isScreenLocked;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [DEMO_APPDELEGATE.pdfViewCtrl willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [DEMO_APPDELEGATE.readFrame willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [DEMO_APPDELEGATE.pdfViewCtrl willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [DEMO_APPDELEGATE.pdfViewCtrl didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [DEMO_APPDELEGATE.readFrame didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

@end
