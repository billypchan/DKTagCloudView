# DKTagCloudView
![GIF](https://raw.githubusercontent.com/zhangao0086/DKTagCloudView/master/preview1.gif)
![GIF](https://raw.githubusercontent.com/zhangao0086/DKTagCloudView/master/preview2.gif)


Weighted font size example, the label's size is propotional to string's length:

(https://raw.githubusercontent.com/zhangao0086/DKTagCloudView/master/preview_sizeRelatedToLength.png)
## Overview
DKTagCloudView is a tag clouds view on iOS. It can generate a random and not intersects coordinates.
This fork supports label size links to custom ratio.

## How To Get Started

### Installation with CocoaPods

Edit your Podfile and add DKTagCloudView:

``` bash
pod 'DKTagCloudView', :git => 'https://github.com/billypchan/DKTagCloudView.git'
```

Add `#import "DKTagCloudView.h"` to the top of classes that will use it.  
#### Create instances (Also supports xib/storyboard) :

``` objective-c
DKTagCloudView *tagCloudView = [[DKTagCloudView alloc] initWithFrame:CGRectMake(0, 64,
                                                                                self.view.bounds.size.width,
                                                                                self.view.bounds.size.height - 64)];
[self.view addSubview:tagCloudView];
self.tagCloudView = tagCloudView;
```

#### Setup items:

``` objective-c
self.tagCloudView.titls = @[
                            @"DKTagCloudView",
                            @"minFontSize",
                            @"maxFontSize",
                            @"randomColors",
                            @"generate",
                            @"UIView",
                            @"NSInteger",
                            @"Min font size",
                            @"Max font size",
                            @"DKTagCloudViewDemo",
                            @"This is a test"
                            ];
```
If you want the size of the label is propertional to their weight, please set labelSizeType properties to kWeighted and assign  array to titleWeights:

``` objective-c
self.tagCloudView.labelSizeType  = kWeighted;
self.tagCloudView.titls = @[
                            @{@"title": @"DKTagCloudView", @"weight" : @14},
                            @{@"title": @"minFontSize", @"weight" : @11},
                            :
                            ];
```

#### Generates:

``` objective-c
[self.tagCloudView generate];
```

#### Callback

``` objective-c
[self.tagCloudView setTagClickBlock:^(NSString *title, NSInteger index) {
    NSLog(@"title:%@,index:%zd",title,index);
}];
```

#### Customized:

``` objective-c
/**
 *  Min font size. Defautls to 14.
 */
@property (nonatomic, assign) NSInteger minFontSize;

/**
 *  Max font size. Defaults to 60.
 */
@property (nonatomic, assign) NSInteger maxFontSize;

/**
 *  Random text colors. Defaults to: 
 [
         [UIColor blackColor],
         [UIColor cyanColor],
         [UIColor purpleColor],
         [UIColor orangeColor],
         [UIColor redColor],
         [UIColor yellowColor],
         [UIColor lightGrayColor],
         [UIColor grayColor],
         [UIColor greenColor],
 ]
 */
@property (nonatomic, copy) NSArray *randomColors;
```

## License
This code is distributed under the terms and conditions of the <a href="https://github.com/zhangao0086/DKTagCloudView/master/LICENSE">MIT license</a>.
