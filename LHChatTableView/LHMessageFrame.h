//
//  LHMessageFrame.h
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#define ChatMargin 10       //间隔
#define ChatIconWH 44       //头像宽高height、width
#define ChatPicWH 200       //图片宽高
#define ChatContentW 180    //内容宽度

#define ChatContentTopBottom 8 //文本内容与气泡上边缘间隔
#define ChatContentLeftBottom 10 //文本内容与气泡左右边缘间隔

#define ChatContentBiger 20         //文本内容带角的一端
#define ChatContentSmaller 8     //文本内容不带角的一端

#define ChatTimeFont [NSFont systemFontOfSize:11]    //时间字体
#define ChatContentFont [NSFont systemFontOfSize:14] //内容字体

NS_ASSUME_NONNULL_BEGIN

@class LHMessage;
@interface LHMessageFrame : NSObject

@property (nonatomic, assign) CGFloat tableViewWidth;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect nameF;
@property (nonatomic, assign, readonly) CGRect contentF;    // 气泡的frame
@property (nonatomic, assign, readonly) CGRect contentStrF;    // 气泡文本的frame
@property (nonatomic, assign, readonly) CGRect pictureF;    // 气泡文本的frame
@property (nonatomic, assign, readonly) CGRect statusF;    // 发送状态的frame


@property (nonatomic, assign, readonly) CGFloat cellHeight;
@property (nonatomic, strong) LHMessage *message;

@property (nonatomic, assign) BOOL showTime;

@end

NS_ASSUME_NONNULL_END
