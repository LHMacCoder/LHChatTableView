//
//  LHMessage.h
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MessageType) {
    LHMessageTypeText     = 0 , // 文字
    LHMessageTypePicture  = 1 , // 图片
    LHMessageTypeVoice    = 2   // 语音
};

typedef NS_ENUM(NSInteger, MessageFrom) {
    LHMessageFromMe    = 0,   // 自己发的
    LHMessageFromOther = 1    // 别人发得
};

typedef NS_ENUM(NSInteger, MessageSendStatus) {
    LHMessageSendFail = 0,  // 发送失败
    LHMessageSendSuccess   = 1   // 发送成功
};

NS_ASSUME_NONNULL_BEGIN

@interface LHMessage : NSObject

@property (nonatomic, copy) NSString *strIcon;
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strTime;
@property (nonatomic, copy) NSString *strName;
@property (nonatomic, copy) NSString *strStatus;

@property (nonatomic, copy) NSString *strContent;
@property (nonatomic, copy) NSImage  *picture;
@property (nonatomic, copy) NSData   *voice;
@property (nonatomic, copy) NSString *strVoiceTime;

@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign) MessageFrom from;
@property (nonatomic, assign) MessageSendStatus status;


@property (nonatomic, assign) BOOL showDateLabel;

- (void)setWithDict:(NSDictionary *)dict;

- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end;

@end

NS_ASSUME_NONNULL_END
