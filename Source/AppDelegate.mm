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
#import "AppDelegate.h"
#import "ViewController.h"
#import <FoxitRDK/FSPDFViewControl.h>
#import "DocumentModule.h"
#import "SettingBar.h"
#import "PasswordModule.h"

@interface AppDelegate()

@property (nonatomic, strong) PasswordModule* passwordModule;
@property (nonatomic, strong) NSString* userName;

@end

@implementation AppDelegate

+ (void)initialize
{
    [self copyPDFFromResourceToDocuments:@"getting_started_ios" overwrite:NO];
}

+(BOOL) copyPDFFromResourceToDocuments:(NSString*)filename overwrite:(BOOL)overwrite
{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString* fromPath = [[NSBundle mainBundle] pathForResource:filename ofType:@"pdf"];
    if (!fromPath)
        return NO;
    
    NSString *toPath = [DOCUMENT_PATH stringByAppendingPathComponent:[filename stringByAppendingString:@".pdf"]];
    if ([fileManager fileExistsAtPath:toPath]) {
        if (overwrite) {
            if (![fileManager removeItemAtPath:toPath error:nil]) {
                return NO;
            }
        } else {
            return NO;
        }
    }
    
    NSError *error  = nil;
    if ([fileManager copyItemAtPath:fromPath toPath:toPath error:&error]) {
        return YES;
    } else {
        FoxitLog(@"Fail to copy %@. %@", filename, [error localizedDescription]);
        return NO;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.backgroundColor = [UIColor whiteColor];

    NSString* sn = @"VQv/htdRKu1rjhk90MTKF+/aCs9he3raJNE2HZ6uxJ0wKcGVsU6+GQ==";
    NSString* key = @"ezKXj1/GvGh39zvoP2Xsb3F6ZiHkO0GJfoWNMeLhSZ63JJ3dieBQl2mCL24l19hVo9Zxkh3xQ4cP5rcm840iAyOxewEnt45P6moo5+QVRwdFHCkwPXmKaPdQZJFMsVc/D5ob5a2o1MeaPrm+4q9DbwQfa6RWD14GSs/cBjlvKNEbS/UBxbEzbVaYXzdQPxWY8/GaIh5Zrnvve3FHuus56p76lRyKgrV/mY1KlcUAU+dFhRNY39WIsXu/OlACBPgC+s0SHZrH8491AwX+bf3AvpZfIlPHXUH9v6dwptxNmsn+WuleSNrMboCjR1Rf8JHSCvOefKQXWyYrJaziZfTnfX4SnjJS3dD9kVInt4wVQEfn4OmCErUJ2KcLsdceKTUbGKTPiRyzIYp0jKtaZxKQXutUrynOPepJbg82XCyb21kwF4nlrTcKRNCzXb1OuHMR3wFaheyPMX0NII2HgLDXZmDQz9BRXn/leilW8uPKq80xCFqi23/wgh3XQVp/rR55OOJrjeIElWupI93KernRAwjXHcjznQa7eT2j9Bh68VKfzD5WveuQvIcXfprdNYXUfQEYQdc0YdotWM5cO0qsf/+pYlC01LEhHCy5v6YbIwceN0j3awucrcZCLVspA8phyZnq9B2KV0nJQZPaVIUTeNjxOXACFLmxeqbtDw17IlgMc5aFEbLTv/vsg/atXlwtftwvS9UQxkSk6LjL1Htmz8dT94t/tCbdZTR0OwbDPS8UifWRmk/FdEuIFTMl/sOV8cWlKm013CmM0MBURbggNrovO+8gKvG+iq85BR36S7+YFh2r4bv1zuv9KYNTp2Fu1zXTRmvcAJ6/bMS9gibpjtcYc3vE/BFhyRZx2Rl5povNBSLMuVXp8QuOPGuPNKCYve2ysTBSzXNVTD+oyK2qlaLykUNBaj5ip3xf/gCASwSA1RmMBoXANxVv+9FLOmuuMrMkMfItX10ygvy5H9XmZ5Rsrw1hp9o6+gdtSp87pArFjzkKHWERakrHf3iOySoVXyCJRI7UL0PpM1HWYw0Lz7qA47qN+eJlfzcF+8LXppMoTzhk+u9pdApg0mTjh1C8ClEVQqID+kXLPEuoQIkOhLn0ddvAQTzC41tStW7PG23X3ZD4RsoJ7HPM9p0tcgiqGpgjxp3cO7KbhWcgrT1A6dgDBvssTryLW19W5h41jg2Upaj3Ic7F1t0t9qvA2bM=";
    enum FS_ERRORCODE eRet = [FSLibrary init:sn key:key];
    if (e_errSuccess != eRet) {
        NSString* errMsg = [NSString stringWithFormat:@"Invalid license"];
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Check License" message:errMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
        [alert show];
        return NO;
    }
    
    self.userName = [[UIDevice currentDevice].name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    _pdfViewCtrl = [[FSPDFViewCtrl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.readFrame = [[[ReadFrame alloc] initWithPdfViewCtrl:self.pdfViewCtrl] autorelease];
    [_pdfViewCtrl registerDocEventListener:self.readFrame];
    
    return YES;
}
				
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self.readFrame.settingBarController.settingBar applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.readFrame.settingBarController.settingBar applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self.readFrame.settingBarController.settingBar applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.readFrame.settingBarController.settingBar applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)openPDFAtPath:(NSString*)path withPassword:(NSString*)password
{
    FSPDFDoc* pdfDoc = [FSPDFDoc createFromFilePath:path];
    if (nil == pdfDoc)
        return NO;
    
    self.filePath = path;
    enum FS_ERRORCODE status = [pdfDoc load:password];
    if(status == e_errSuccess) {
        [_pdfViewCtrl setDoc:pdfDoc];
        
        UIViewController* pdfViewController = [[[UIViewController alloc] init] autorelease];
        pdfViewController.view = _pdfViewCtrl;
        pdfViewController.automaticallyAdjustsScrollViewInsets = NO;
        [((ViewController*)self.window.rootViewController).navController pushViewController:pdfViewController animated:YES];
    }
    else if (status == e_errPassword) {
        if (!self.passwordModule) {
            self.passwordModule = [[[PasswordModule alloc] init] autorelease];
        }
        
        self.passwordModule.pdfDoc = pdfDoc;
        [self.passwordModule promptWithTitle:password ? NSLocalizedString(@"kDocPasswordError", nil) : NSLocalizedString(@"kDocNeedPassword", nil) callback:^(BOOL pressedOK, NSString *newPassword) {
            if (pressedOK)
                [self openPDFAtPath:path withPassword:newPassword];
        }];
    }
    else {
        UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:NSLocalizedString(@"kFailOpenFile", nil), [path lastPathComponent]]
                                                         message:status == e_errSecurityHandler ? NSLocalizedString(@"kInvalidSecurityHandler", nil) : [NSString stringWithFormat:NSLocalizedString(@"kErrorCode", nil), status]
                                                        delegate:nil
                                               cancelButtonTitle:NSLocalizedString(@"kOK", nil) otherButtonTitles:nil, nil] autorelease];
        [alert show];
    }
    return YES;
}


@end
