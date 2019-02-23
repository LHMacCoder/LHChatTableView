//
//  LHMessageCell.m
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import "LHMessageCell.h"
#import "LHMessageFrame.h"
#import "LHMessage.h"

@interface LHMessageCell ()

@property (nonatomic, strong) NSTextField *dateLabel;
@property (nonatomic, strong) NSTextField *namelabel;
@property (nonatomic, strong) NSTextField *contentlabel;
@property (nonatomic, strong) NSTextField *statuslabel;    // 发送状态label

@property (nonatomic, strong) NSImageView *bubbleContent;
@property (nonatomic, strong) NSImageView *headImageBackView;


@end

@implementation LHMessageCell

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
    {
        self.bubbleContent = [[NSImageView alloc] init];
        self.bubbleContent.imageScaling = NSImageScaleAxesIndependently;
        [self addSubview:self.bubbleContent];
        
        // 1、创建时间
        self.dateLabel = [[NSTextField alloc] init];
        self.dateLabel.alignment = NSCenterTextAlignment;
        self.dateLabel.textColor = [NSColor grayColor];
        self.dateLabel.font = ChatTimeFont;
        [self.dateLabel setEditable:NO];
        [self.dateLabel setBordered:NO];
        [self.dateLabel setDrawsBackground:NO];
        [self addSubview:self.dateLabel];
        
        // 2、创建头像
        self.headImageBackView = [[NSImageView alloc] init];
        [self.headImageBackView setWantsLayer:YES];
        self.headImageBackView.layer.cornerRadius = 22;
        self.headImageBackView.layer.masksToBounds = YES;
        [self addSubview:_headImageBackView];
        
        // 3、创建头像下标
        self.namelabel = [[NSTextField alloc] init];
        self.namelabel.textColor = [NSColor grayColor];
        self.namelabel.alignment = NSCenterTextAlignment;
        self.namelabel.font = ChatTimeFont;
        [self.namelabel setEditable:NO];
        [self.namelabel setBordered:NO];
        [self.namelabel setDrawsBackground:NO];
        [self addSubview:self.namelabel];
        
        // 4、创建内容
        self.contentlabel = [[NSTextField alloc] init];
        self.contentlabel.textColor = [NSColor blackColor];
        self.contentlabel.alignment = NSLeftTextAlignment;
        self.contentlabel.font = ChatContentFont;
        [self.contentlabel setEditable:NO];
        [self.contentlabel setBordered:NO];
        [self.contentlabel setDrawsBackground:NO];
        [self.contentlabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:self.contentlabel];
        
        // 5. 发送状态
        self.statuslabel = [[NSTextField alloc] init];
        self.statuslabel.textColor = [NSColor redColor];
        self.statuslabel.alignment = NSCenterTextAlignment;
        self.statuslabel.font = ChatContentFont;
        [self.statuslabel setEditable:NO];
        [self.statuslabel setBordered:NO];
        [self.statuslabel setDrawsBackground:NO];
        [self addSubview:self.statuslabel];

    }
    return self;
}

- (BOOL)isFlipped
{
    return YES;
}

//内容及Frame设置
- (void)setMessageFrame:(LHMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    LHMessage *message = messageFrame.message;
    
    // 1、设置时间
    self.dateLabel.stringValue = message.strTime;
    self.dateLabel.frame = messageFrame.timeF;
    
    // 2、设置头像
    _headImageBackView.frame = messageFrame.iconF;
    [_headImageBackView setImage:[NSImage imageNamed:@"headImage"]];
    
    // 3、设置下标
    self.namelabel.stringValue = message.strName;
    self.namelabel.frame = messageFrame.nameF;
    
    // 4、设置内容
    self.contentlabel.stringValue = message.strContent;
    self.contentlabel.frame = messageFrame.contentStrF;
    self.bubbleContent.frame = messageFrame.contentF;
    
    //背景气泡图
    if (message.from == LHMessageFromMe)
    {
        [_bubbleContent setImage:[NSImage imageNamed:@"chatto_bg_normal"]];
    }
    else
    {
        [_bubbleContent setImage:[NSImage imageNamed:@"chatfrom_bg_normal"]];
    }
    
    switch (message.type)
    {
        case LHMessageTypeText:
        {
            
        }
            break;
        case LHMessageTypePicture:
        {
            [_bubbleContent setImage:message.picture];
            [_bubbleContent setFrame:messageFrame.pictureF];
            [_bubbleContent setImageAlignment:NSImageAlignCenter];
            [_bubbleContent setImageScaling:NSImageScaleProportionallyUpOrDown];
        }
            break;
        case LHMessageTypeVoice:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    // 发送状态
    self.statuslabel.stringValue = message.strStatus;
    self.statuslabel.frame = messageFrame.statusF;
}

@end
