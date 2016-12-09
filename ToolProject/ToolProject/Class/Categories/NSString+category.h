//
//  NSString+category.h
//  iSalerMan
//
//  Created by frank weng on 14-9-27.
//  Copyright (c) 2014年 zjhcsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (category)
//-(NSNumber*)toNumber

-(CGFloat)widthWithFont:(CGFloat)fontSize;
-(NSDictionary*)toDict;
//单独计算文本的宽度
+ (CGFloat)widthForText:(NSString *)text size:(CGFloat)_size;

//字典转json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

@end
