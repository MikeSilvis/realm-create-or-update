//
//  MLSTicket.m
//  Realm Create Or Update
//
//  Created by Mike Silvis on 10/7/15.
//  Copyright © 2015 Mike Silvis. All rights reserved.
//

#import "MSTicket.h"

@implementation MSTicket

+ (NSDictionary *)defaultPropertyValues {
    return @{@"seat" : @"", @"pdf" : [NSData new]};
}

+ (NSString *)primaryKey {
    return @"objectID";
}

@end
