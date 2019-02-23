//
//  AppDelegate.m
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import "AppDelegate.h"
#import "LHChatCategory.h"
#import "LHChatModel.h"
#import "LHMessageFrame.h"
#import "LHMessage.h"
#import "LHMessageCell.h"

@interface AppDelegate ()<NSTableViewDelegate,NSTableViewDataSource>
{
    LHChatModel *_chatModel;
}

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *chatTableView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application

    CGFloat viewWidth = NSWidth(self.chatTableView.frame);
    _chatModel = [[LHChatModel alloc ] init];
    for (int i = 0;i < 10;i++)
    {
        LHMessageFrame *messageFrame = [[LHMessageFrame alloc]init];
        LHMessage *message = [[LHMessage alloc] init];
        message.strTime = [NSString stringWithFormat:@"2019-02-13 17:%i:00",i+6];
        message.strName = @"linhao";
        messageFrame.showTime = YES;

        if (i % 2 == 0)
        {
            message.from = LHMessageFromMe;
            message.strContent = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus gravida, felis orci dictum risus, sed sodales sem eros eget risus. Morbi imperdiet sed diam et sodales.";
            message.strStatus = @"Unsend";
            message.status = LHMessageSendSuccess;
        }
        else
        {
            message.from = LHMessageFromOther;
            message.strContent = @"Lorem ipsum dolor sit amet";
            message.status = LHMessageSendFail;
            message.strStatus = @"Unsend";
        }
        message.type = LHMessageTypeText;
        if ( i == 4)
        {
            message.type = LHMessageTypePicture;
            message.strContent = @"";
            message.picture = [NSImage imageNamed:@"0"];
            messageFrame.showTime = NO;

        }
        if ( i == 5)
        {
            message.type = LHMessageTypePicture;
            message.strContent = @"";
            message.picture = [NSImage imageNamed:@"111"];
            messageFrame.showTime = NO;

        }
//        messageFrame.showTime = message.showDateLabel;

        messageFrame.tableViewWidth = viewWidth;
        [messageFrame setMessage:message];
        [_chatModel.dataSource addObject:messageFrame];
    }
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    [self.chatTableView reloadData];
    
    NSLog(@"%f",NSWidth(self.chatTableView.frame));
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

#pragma mark - NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _chatModel.dataSource.count;
}

#pragma mark - NSTableViewDelegate
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    LHMessageFrame *frame = _chatModel.dataSource[row];
    return frame.cellHeight;
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    LHMessageCell *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    LHMessageFrame *frame = _chatModel.dataSource[row];
    cellView.messageFrame = frame;
    return cellView;
}


@end
