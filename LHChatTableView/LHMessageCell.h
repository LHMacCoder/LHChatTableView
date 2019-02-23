//
//  LHMessageCell.h
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class LHMessageFrame;
@interface LHMessageCell : NSTableCellView

@property (nonatomic, strong) LHMessageFrame *messageFrame;

@end

NS_ASSUME_NONNULL_END
