//
//  NSString+LHChatCategory.h
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LHChatCategory)

// 计算不准确，慎用！
-(CGSize)sizeOfStringWithGivenFont:(NSFont*)font constrainedToSize:(CGSize)size;

@end


NS_ASSUME_NONNULL_END
