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
#import "MoreAnnotationsBar.h"
#import <FoxitRDK/FSPDFViewControl.h>


@interface MoreAnnotationsBar ()

//TextMarkup
@property (nonatomic,retain) UILabel *textLabel;

@property (nonatomic,retain) UIButton *highlightBtn;
@property (nonatomic,retain) UIButton *underlineBtn;
@property (nonatomic,retain) UIButton *breaklineBtn;
@property (nonatomic,retain) UIButton *strokeoutBtn;

@property (nonatomic,retain) UIView *divideView1;


//Others
@property (nonatomic,retain) UILabel *othersLabel;

@property (nonatomic,retain) UIButton *noteBtn;


@end

@implementation MoreAnnotationsBar


-(MoreAnnotationsBar*)init:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.contentView = [[UIView alloc] initWithFrame:frame];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //TextMarkup
        self.textLabel = [[[UILabel alloc] init] autorelease];
        self.textLabel.text = NSLocalizedString(@"kMoreTextMarkup", nil);
        self.textLabel.font = [UIFont systemFontOfSize:16.0f];
        self.textLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.textLabel];
        
        
        UIImage *hightImage = [UIImage imageNamed:@"annot_hight"];
        UIImage *underlineImage = [UIImage imageNamed:@"annot_underline"];
        UIImage *breaklineImage = [UIImage imageNamed:@"annot_breakline"];
        UIImage *strokeoutImage = [UIImage imageNamed:@"annot_strokeout"];
        self.highlightBtn = [MoreAnnotationsBar createItemWithImage:hightImage];
        self.underlineBtn = [MoreAnnotationsBar createItemWithImage:underlineImage];
        self.breaklineBtn = [MoreAnnotationsBar createItemWithImage:breaklineImage];
        self.strokeoutBtn = [MoreAnnotationsBar createItemWithImage:strokeoutImage];
        
        self.highlightBtn.frame = CGRectMake(0, 100, hightImage.size.width, hightImage.size.height);
        self.underlineBtn.frame = CGRectMake(0, 100, underlineImage.size.width, underlineImage.size.height);
        self.breaklineBtn.frame = CGRectMake(0, 100, breaklineImage.size.width, breaklineImage.size.height);
        self.strokeoutBtn.frame = CGRectMake(0, 100, strokeoutImage.size.width, strokeoutImage.size.height);
        
        [self.contentView addSubview:self.highlightBtn];
        [self.contentView addSubview:self.underlineBtn];
        [self.contentView addSubview:self.breaklineBtn];
        [self.contentView addSubview:self.strokeoutBtn];
        
        self.divideView1 = [[[UIView alloc] init] autorelease];
        self.divideView1.backgroundColor = [UIColor colorWithRGBHex:0xe6e6e6];
        [self.contentView addSubview:self.divideView1];
        

        //Others
        self.othersLabel = [[[UILabel alloc] init] autorelease];
        self.othersLabel.text = NSLocalizedString(@"kMoreOthers", nil);
        self.othersLabel.font = [UIFont systemFontOfSize:16.0f];
        self.othersLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.othersLabel];
        

        UIImage *noteImage = [UIImage imageNamed:@"annot_note_more"];
        self.noteBtn = [MoreAnnotationsBar createItemWithImageAndTitle:NSLocalizedString(@"kNote", nil) imageNormal:noteImage];
        self.noteBtn.frame = CGRectMake(0, 230, self.noteBtn.bounds.size.width,self.noteBtn.bounds.size.height);
        [self.contentView addSubview:self.noteBtn];

        // build layout
        {
            int label_height = 20;
            int btn_height = self.highlightBtn.frame.size.height;
            self.highlightBtn.center = CGPointMake((frame.size.width-20)/12, 120 - btn_height - label_height);
            self.underlineBtn.center = CGPointMake((frame.size.width-20)/12*3, 120 - btn_height - label_height);
            self.breaklineBtn.center = CGPointMake((frame.size.width-20)/12*5, 120 - btn_height - label_height);
            self.strokeoutBtn.center = CGPointMake((frame.size.width-20)/12*7, 120 - btn_height - label_height);
            
            [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.highlightBtn.mas_left).offset(0);
                make.top.equalTo(self.contentView.mas_top).offset(10);
                make.width.mas_equalTo(200);
                make.height.mas_equalTo(label_height);
            }];
            
            [self.divideView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).offset(5);
                make.right.equalTo(self.contentView.mas_right).offset(-5);
                make.top.equalTo(self.contentView.mas_top).offset(100);
                make.height.mas_equalTo([Utility realPX:1.0f]);
            }];
            
            [self.othersLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.highlightBtn.mas_left).offset(0);
                make.top.equalTo(self.contentView.mas_top).offset(160 - btn_height - label_height);
                make.width.mas_equalTo(200);
                make.height.mas_equalTo(20);
            }];
            
            self.noteBtn.center = CGPointMake((frame.size.width-20)/8, 210 - btn_height - label_height);
        }
        
        [self onItemOnClicked];
        
    }
    return self;
}


-(void)onItemOnClicked
{
    [self.highlightBtn addTarget:self action:@selector(onHighLightClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.underlineBtn addTarget:self action:@selector(onUnderLineClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.breaklineBtn addTarget:self action:@selector(onBreakLineClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.strokeoutBtn addTarget:self action:@selector(onStrikeOutClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.noteBtn addTarget:self action:@selector(onNoteClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onHighLightClicked
{
    if (self.highLightClicked) {
        self.highLightClicked();
    }
}

-(void)onUnderLineClicked
{
    if (self.underLineClicked) {
        self.underLineClicked();
    }
}

-(void)onStrikeOutClicked
{
    if (self.strikeOutClicked) {
        self.strikeOutClicked();
    }
}

-(void)onBreakLineClicked
{
    if (self.breakLineClicked) {
        self.breakLineClicked();
    }
}

-(void)onNoteClicked
{
    if (self.noteClicked) {
        self.noteClicked();
    }
}


- (void)dealloc {
    [super dealloc];
}

//create button with image.
+(UIButton*)createItemWithImage:(UIImage*)imageNormal
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentMode = UIViewContentModeScaleToFill;
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:[MoreAnnotationsBar imageByApplyingAlpha:imageNormal alpha:0.5] forState:UIControlStateHighlighted];
    [button setImage:[MoreAnnotationsBar imageByApplyingAlpha:imageNormal alpha:0.5] forState:UIControlStateSelected];
    return button;
}

+ (UIButton*)createItemWithImageAndTitle:(NSString*)title
                             imageNormal:(UIImage*)imageNormal
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize titleSize = [Utility getTextSize:title fontSize:12.0f maxSize:CGSizeMake(300, 200)];
    
    float width = imageNormal.size.width ;
    float height = imageNormal.size.height ;
    button.contentMode = UIViewContentModeScaleToFill;
    [button setImage:imageNormal forState:UIControlStateNormal];
    [button setImage:[MoreAnnotationsBar imageByApplyingAlpha:imageNormal alpha:0.5] forState:UIControlStateHighlighted];
    [button setImage:[MoreAnnotationsBar imageByApplyingAlpha:imageNormal alpha:0.5] forState:UIControlStateSelected];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -width, -height, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height, 0, 0, -titleSize.width);
    button.frame = CGRectMake(0, 0, titleSize.width > width ? titleSize.width + 2: width,  titleSize.height + height);
    
    return button;
}

+ (UIImage *)imageByApplyingAlpha:(UIImage*)image alpha:(CGFloat) alpha {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
