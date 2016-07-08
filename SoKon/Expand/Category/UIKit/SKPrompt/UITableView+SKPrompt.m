//
//  UITableView+SKPrompt.m
//  SoKon
//
//  Created by nachuan on 16/6/29.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "UITableView+SKPrompt.h"
#import "SKNothingShow.h"
#import <objc/runtime.h>
@implementation NSObject (SKPrompt)

/**
 *  方法替换,此处暂未用到
 */
//+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
//{
//    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
//}
//
//+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
//{
//    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
//}

@end

@implementation UITableView (SKPrompt)
static const char SKPromptKey = '$';
- (void)setSk_prompt:(SKNothingShow *)sk_prompt
{
    if (self.sk_prompt != sk_prompt) {
        [self.sk_prompt removeFromSuperview];
        [self addSubview:sk_prompt];
        [self willChangeValueForKey:@"sk_prompt"];
        objc_setAssociatedObject(self, &SKPromptKey, sk_prompt, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"sk_prompt"];
    }
}

- (SKNothingShow *)sk_prompt
{
    return objc_getAssociatedObject(self, &SKPromptKey);
}

@end
