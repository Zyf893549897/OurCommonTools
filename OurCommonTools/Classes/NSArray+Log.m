//
//  NSArray+Log.m
//  botella
//
//  Created by 周泽文 on 2021/12/21.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale

{

    NSMutableString *string = [NSMutableString string];

    

    // 开头有个[

    [string appendString:@"[\n"];

    

    // 遍历所有的元素

    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,BOOL *stop) {

        [string appendFormat:@"\t%@,\n", obj];

    }];

    

    // 结尾有个]

    [string appendString:@"]"];

    

    // 查找最后一个逗号

    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];

    if (range.location != NSNotFound)

    [string deleteCharactersInRange:range];

    

    return string;

}

@end
