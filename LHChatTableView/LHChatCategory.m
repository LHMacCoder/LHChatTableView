//
//  NSString+LHChatCategory.m
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LHChatCategory.h"

@implementation NSString (LHChatCategory)

-(CGSize)sizeOfStringWithGivenFont:(NSFont*)font constrainedToSize:(CGSize)size;
{
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:self];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithContainerSize: NSMakeSize(size.width, FLT_MAX)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    
    [textStorage addAttribute:NSFontAttributeName value:font
                        range:NSMakeRange(0, [textStorage length])];
    [textContainer setLineFragmentPadding:0.0];
    
    (void) [layoutManager glyphRangeForTextContainer:textContainer];
    
    // 根据size获取合适的高度
    CGFloat height = [layoutManager usedRectForTextContainer:textContainer].size.height;
    
    // 根据size获取合适的宽度
    NSTextStorage *textStorageH = [[NSTextStorage alloc] initWithString:self];
    NSTextContainer *textContaineH = [[NSTextContainer alloc] initWithContainerSize: NSMakeSize(FLT_MAX, size.height)];
    
    [layoutManager addTextContainer:textContaineH];
    [textStorageH addLayoutManager:layoutManager];
    
    [textStorageH addAttribute:NSFontAttributeName value:font
                        range:NSMakeRange(0, [textStorage length])];
    [textContaineH setLineFragmentPadding:0.0];
    
    (void) [layoutManager glyphRangeForTextContainer:textContainer];
    
    CGFloat width = MIN([layoutManager usedRectForTextContainer:textContainer].size.width, size.width);
    
    return CGSizeMake(width, height);
}

@end
