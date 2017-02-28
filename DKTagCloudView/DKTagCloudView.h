//
//  DKTagCloudView.h
//  DKTagCloudViewDemo
//
//  Created by ZhangAo on 14-11-18.
//  Copyright (c) 2014年 zhangao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKTagCloudView : UIView

typedef enum LabelSizeType : NSUInteger {
    kRandom,
    kWeighted,
} LabelSizeType;


@property (nonatomic, assign) LabelSizeType labelSizeType;

/**
 *  Min font size. Defautls to 14.
 */
@property (nonatomic, assign) NSInteger minFontSize;

/**
 *  Max font size. Defaults to 60.
 */
@property (nonatomic, assign) NSInteger maxFontSize;

/**
 *  Random text colors. Defaults to: <br />
 [<br />
         [UIColor blackColor],<br />
         [UIColor cyanColor],<br />
         [UIColor purpleColor],<br />
         [UIColor orangeColor],<br />
         [UIColor redColor],<br />
         [UIColor yellowColor],<br />
         [UIColor lightGrayColor],<br />
         [UIColor grayColor],<br />
         [UIColor greenColor],<br />
 ]
 */
@property (nonatomic, copy) NSArray *randomColors;

@property (nonatomic, copy) NSArray *titls; // @[ NSString... ]
@property (nonatomic, copy) NSArray *titleWeights; // @[ (NSString, Int)... ]

/**
 *  Callback. Index start at 0.
 */
@property (nonatomic, copy) void (^tagClickBlock)(NSString *title, NSInteger index);

- (void)generate :(void (^) (UILabel *label))labelCreatedHandler;

@end
