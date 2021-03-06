//
//  DKTagCloudView.m
//  DKTagCloudViewDemo
//
//  Created by ZhangAo on 14-11-18.
//  Copyright (c) 2014年 zhangao. All rights reserved.
//

#import "DKTagCloudView.h"

@interface DKTagCloudView ()

@property (nonatomic, strong) NSMutableArray *labels;

@end

@implementation DKTagCloudView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.labelSizeType = kRandom;
    
    self.userInteractionEnabled = YES;
    self.minFontSize = 14;
    self.maxFontSize = 60;
    self.randomColors = @[
                          [UIColor blackColor],
                          [UIColor cyanColor],
                          [UIColor purpleColor],
                          [UIColor orangeColor],
                          [UIColor redColor],
                          [UIColor yellowColor],
                          [UIColor lightGrayColor],
                          [UIColor grayColor],
                          [UIColor greenColor]
                          ];
}

- (UIColor *)randomColor {
    return self.randomColors[rand() % self.randomColors.count];
}

- (UIFont *)randomFont {
    return [UIFont systemFontOfSize:rand() % self.maxFontSize + self.minFontSize];
}

- (UIFont *)sizeRatioFont:(float)ratio {
    return [UIFont systemFontOfSize:ratio * (self.maxFontSize - self.minFontSize) + self.minFontSize];
}

- (CGRect)randomFrameForLabel:(UILabel *)label {
    [label sizeToFit];
    CGFloat maxWidth = self.bounds.size.width - label.bounds.size.width;
    CGFloat maxHeight = self.bounds.size.height - label.bounds.size.height;
    
    return CGRectMake(random() % (NSInteger)maxWidth, random() % (NSInteger)maxHeight,
                      CGRectGetWidth(label.bounds), CGRectGetHeight(label.bounds));
}

- (BOOL)frameIntersects:(CGRect)frame {
    for (UILabel *label in self.labels) {
        if (CGRectIntersectsRect(frame, label.frame)) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray *)labels {
    if (_labels == nil) {
        _labels = [NSMutableArray new];
    }
    return _labels;
}

- (void)generate :(void (^) (UILabel *label))labelCreatedHandler {
    [self.labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labels removeAllObjects];
    
    
    if (self.labelSizeType == kWeighted) {
        
        int maxWeight= [[self.titleWeights valueForKeyPath: @"@max.weight"] intValue];
        int minWeight= [[self.titleWeights valueForKeyPath: @"@min.weight"] intValue];
        float diff = maxWeight - minWeight;
        
        int i = 0;
        
        for (NSDictionary *titleWeight in self.titleWeights) {
            assert([titleWeight isKindOfClass:[NSDictionary class]]);
            UILabel *label = [[UILabel alloc] init];
            label.tag = i++;
            label.text = titleWeight[@"title"];
            label.textColor = [self randomColor];
            
            
            float delta = [titleWeight[@"weight"] intValue] - minWeight;
            float ratio = delta/diff;
            
            label.font = [self sizeRatioFont:ratio];
            
            do {
                label.frame = [self randomFrameForLabel:label];
            } while ([self frameIntersects:label.frame]);
            
            [self.labels addObject:label];
            [self addSubview:label];
            
            UITapGestureRecognizer *tagGestue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
            [label addGestureRecognizer:tagGestue];
            label.userInteractionEnabled = YES;
             labelCreatedHandler(label);
        }
    }
    else {
        ///TODO: calc max/min length
        
        int i = 0;
        
        
        int maxLength= [[self.titls valueForKeyPath: @"@max.length"] intValue];
        int minLength= [[self.titls valueForKeyPath: @"@min.length"] intValue];
        float diff = maxLength - minLength;
        for (NSString *title in self.titls) {
            assert([title isKindOfClass:[NSString class]]);
            
            UILabel *label = [[UILabel alloc] init];
            label.tag = i++;
            label.text = title;
            label.textColor = [self randomColor];
            
            
            float delta = label.text.length - minLength;
            float ratio = delta/diff;
            
            label.font = [self randomFont];
            
            ///TODO: break after 5 sec., throw
            do {
                label.frame = [self randomFrameForLabel:label];
            } while ([self frameIntersects:label.frame]);
            
            [self.labels addObject:label];
            [self addSubview:label];
            
            UITapGestureRecognizer *tagGestue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
            [label addGestureRecognizer:tagGestue];
            label.userInteractionEnabled = YES;
            labelCreatedHandler(label);
        }
    }
}

- (void)handleGesture:(UIGestureRecognizer*)gestureRecognizer {
    UILabel *label = (UILabel *)gestureRecognizer.view;
    if (self.tagClickBlock) {
        self.tagClickBlock(label.text,label.tag);
    }
}

@end
