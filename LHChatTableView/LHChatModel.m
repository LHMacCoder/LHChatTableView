//
//  LHChatModel.m
//  LHChatTableView
//
//  Created by 懒懒米虫 on 2019/2/13.
//  Copyright © 2019 懒懒米虫. All rights reserved.
//

#import "LHChatModel.h"
#import "LHMessageFrame.h"
#import "LHMessage.h"

@implementation LHChatModel

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
