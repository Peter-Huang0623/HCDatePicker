//
//  HCDateModel.m
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import "HCDateModel.h"

@implementation HCDateModel

@end

@implementation HCDateHeaderModel

- (NSString *)headerString
{
    if ([self systemLanguageIsChinese]) {
        return [NSString stringWithFormat:@"%ld年%ld月",self.year,self.month];
    }
    else {
        return [self englishHeaderStr];
    }
}

- (BOOL)systemLanguageIsChinese
{
    NSArray *array = [NSLocale preferredLanguages];
    NSString *languageStr = array[0];
    return [languageStr hasPrefix:@"zh"];
}

- (NSString *)englishHeaderStr
{
    NSMutableString *str = [[NSMutableString alloc] init];
    switch (self.month) {
        case 1: {
            [str appendString:@"January"];
        }
            break;
        case 2: {
            [str appendString:@"February"];
        }
            break;
        case 3: {
            [str appendString:@"March"];
        }
            break;
        case 4: {
            [str appendString:@"April"];
        }
            break;
        case 5: {
            [str appendString:@"May"];
        }
            break;
        case 6: {
            [str appendString:@"June"];
        }
            break;
        case 7: {
            [str appendString:@"July"];
        }
            break;
        case 8: {
            [str appendString:@"August"];
        }
            break;
        case 9: {
            [str appendString:@"September"];
        }
            break;
        case 10: {
            [str appendString:@"October"];
        }
            break;
        case 11: {
            [str appendString:@"November"];
        }
            break;
        case 12: {
            [str appendString:@"December"];
        }
            break;
        default:
            break;
    }
    [str appendFormat:@" %ld",self.year];
    return [NSString stringWithString:str];
}
@end
