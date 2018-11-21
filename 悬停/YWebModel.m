//
//  YWebModel.m
//  悬停
//
//  Created by 尤艺琪 on 2018/10/22.
//  Copyright © 2018年 尤艺琪. All rights reserved.
//

#import "YWebModel.h"

@implementation YWebModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
-(id)valueForUndefinedKey:(NSString *)key {
    return @"";
}

//比较对象, orderSet比较对象时自动调用isEqual
- (BOOL)isEqual:(id)object
{
    // self 和 object，比较相同，返回true
    // 比较不同，返回false
    if (![object isKindOfClass:[YWebModel class]]) {
        return false;
    }
    
    YWebModel* p = (YWebModel *)object;
    if ([p.id isEqualToString:self.id]) {
        return true;
    }
    return false;
}
//快速比较，为每个对象，生成一个识别码，线比较识别码
//对象比较，先比较hash，hash一样，才用isEqual再次比较
- (NSUInteger)hash
{
    return [self.id hash];
}
@end
