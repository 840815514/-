//
//  YWebModel.h
//  悬停
//
//  Created by 尤艺琪 on 2018/10/22.
//  Copyright © 2018年 尤艺琪. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YWebModel : NSObject
@property (nonatomic, strong) NSString *href_addr;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL canDelete;
@property (nonatomic, assign) BOOL canGoToHtml;
@end

