//
//  LHMessageFrame.m
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import "LHMessageFrame.h"
#import "LHMessage.h"
#import "LHChatCategory.h"

@interface LHMessageFrame ()
{
    NSTextField *_calculateTextTField;
}

@end

@implementation LHMessageFrame

- (void)setMessage:(LHMessage *)message{
    
    _message = message;
    
    CGFloat const screenW = _tableViewWidth;
    
    // 1、计算时间的位置
    if (_showTime)
    {
        CGSize timeSize = [_message.strTime sizeOfStringWithGivenFont:ChatTimeFont constrainedToSize:CGSizeMake(300, 100)];
        _timeF = CGRectMake((screenW - timeSize.width) / 2, ChatMargin, timeSize.width, timeSize.height);
    }
    else
    {
        _timeF = CGRectZero;
    }
    
    // 2、计算头像位置
    CGFloat const iconX = _message.from == LHMessageFromOther ? ChatMargin : (screenW - ChatMargin - ChatIconWH);
    _iconF = CGRectMake(iconX, CGRectGetMaxY(_timeF) + ChatMargin, ChatIconWH, ChatIconWH);
    
    // 3、计算ID位置
    CGSize nameSize = [_message.strName sizeOfStringWithGivenFont:ChatTimeFont constrainedToSize:CGSizeMake(ChatIconWH+ChatMargin, 50)];
    _nameF = CGRectMake(iconX-ChatMargin/2.0, CGRectGetMaxY(_iconF) + ChatMargin/2.0, ChatIconWH+ChatMargin, nameSize.height);
    
    // 4、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF) + ChatMargin;
    
    //根据种类分
    CGSize contentSize;
    
    switch (_message.type)
    {
        case LHMessageTypeText:
        {
            contentSize = [self getHeightBySize:CGSizeMake(MAX(ChatContentW, screenW*0.6),FLT_MAX) string:_message.strContent font:ChatContentFont];
            contentSize.width = MAX(contentSize.width, 40);
            if (_message.from == LHMessageFromMe)
            {
                contentX = screenW - (contentSize.width + ChatContentBiger + ChatContentSmaller + ChatMargin + ChatIconWH + ChatMargin);
            }
            // 气泡位置
            _contentF = CGRectMake(contentX, CGRectGetMinY(_iconF) + 5, contentSize.width + ChatContentBiger + ChatContentSmaller, contentSize.height + ChatContentTopBottom * 2);
            // 计算气泡内容位置
            if (_message.from == LHMessageFromOther)
            {
                _contentStrF = CGRectMake(contentX + ChatContentLeftBottom + ChatContentSmaller, CGRectGetMinY(_iconF) + 5 + ChatContentTopBottom, contentSize.width, contentSize.height);
            }
            else
            {
                _contentStrF = CGRectMake(contentX + ChatContentLeftBottom, CGRectGetMinY(_iconF) + 5 + ChatContentTopBottom, contentSize.width, contentSize.height);
            }
            [self calculateCellHeightBy:_contentF x:contentX];
        }
            break;
        case LHMessageTypePicture:
        {
            NSSize pictureSize = [message.picture size];
            CGFloat imageAspectRatio = pictureSize.width / pictureSize.height;
            if (imageAspectRatio > 1)
            {
                contentSize = CGSizeMake(200, 200.0 / pictureSize.width * pictureSize.height);
            }
            else
            {
                contentSize = CGSizeMake(200.0 / pictureSize.height * pictureSize.width, 200);
            }
            if (pictureSize.width < ChatPicWH && pictureSize.height < ChatPicWH)
            {
                contentSize = pictureSize;
            }
            if (_message.from == LHMessageFromMe)
            {
                contentX = screenW - (contentSize.width + ChatMargin + ChatIconWH + ChatMargin);
            }
            // 如果有图片，计算图片位置
            _pictureF = CGRectMake(contentX, CGRectGetMinY(_iconF) + 5, contentSize.width, contentSize.height);
            
            // 计算行高
            [self calculateCellHeightBy:_pictureF x:contentX];
        }
            break;
        case LHMessageTypeVoice:
        {
            contentSize = CGSizeMake(120, 35);
        }
            break;
        default:
            break;
    }
}

- (void)calculateCellHeightBy:(CGRect)rect x:(CGFloat)contentX
{
    // 计算行高
    _cellHeight = MAX(CGRectGetMaxY(rect), CGRectGetMaxY(_nameF))  + ChatMargin;
    
    // 计算发送状态位置
    // 如果发送失败
    if (_message.status == LHMessageSendFail)
    {
        CGSize statusSize = [self getHeightBySize:CGSizeMake(MAX(ChatContentW, _tableViewWidth*0.6),FLT_MAX) string:_message.strStatus font:ChatContentFont];
        _statusF = CGRectMake(contentX, CGRectGetMaxY(rect) + ChatContentTopBottom, statusSize.width, statusSize.height);
        if (_message.from == LHMessageFromMe)
        {
            _statusF = CGRectMake(_tableViewWidth - (statusSize.width + ChatMargin + ChatIconWH + ChatMargin), CGRectGetMaxY(rect) + ChatContentTopBottom, statusSize.width, statusSize.height);
        }
        // 重新计算行高
        _cellHeight = MAX(CGRectGetMaxY(_statusF), CGRectGetMaxY(_nameF))  + ChatMargin;
    }
    else
    {
        _statusF = CGRectZero;
    }
}

- (void)setShowTime:(BOOL)showTime
{
    _showTime = showTime;
    
    if (_message) {
        self.message = _message;
    }
}

- (CGSize)getHeightBySize:(CGSize)size string:(NSString *)string font:(NSFont *)font
{
    CGFloat height = 0.0f;
    CGFloat width = 0.0f;

    if (string && ![string isEqualToString:@""])
    {
        if (_calculateTextTField == nil)
        {
            _calculateTextTField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, width, FLT_MAX)];
        }
        _calculateTextTField.font = font;
        _calculateTextTField.stringValue = string;
        width = size.width;
        height = [_calculateTextTField.cell cellSizeForBounds:NSMakeRect(0, 0, size.width, CGFLOAT_MAX)].height;
        // 计算一行文字的宽度,预估一行文字的高度小于30
        if (height < 30)
        {
            width = [_calculateTextTField.cell cellSizeForBounds:NSMakeRect(0, 0, CGFLOAT_MAX, 100)].width;
        }

    }
    return CGSizeMake(width, height);
}

@end
