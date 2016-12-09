//
//  NSString+category.m
//  iSalerMan
//
//  Created by frank weng on 14-9-27.
//  Copyright (c) 2014年 zjhcsoft. All rights reserved.
//

#import "NSString+category.h"
#import <UIKit/UIKit.h>


@implementation NSString (category)


-(CGFloat)widthWithFont:(CGFloat)fontSize
{
    CGFloat btnWidth;
    
    if([[UIDevice currentDevice] systemVersion].floatValue >= 7.0){
        NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
        btnWidth = [self sizeWithAttributes:attributes].width;
    }else{
        btnWidth = [self sizeWithFont:[UIFont systemFontOfSize:fontSize]].width;
    }
    
    
    return btnWidth;
}


-(NSDictionary*)toDict
{
    NSError* error ;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    
    return dic;
}

//单独计算文本的宽度
+ (CGFloat)widthForText:(NSString *)text size:(CGFloat)_size
{
    //设置计算文本时字体的大小,以什么标准来计算
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:_size]};
    return [text boundingRectWithSize:CGSizeMake(320-20, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.width;
}

//字典转json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
