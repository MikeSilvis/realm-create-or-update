//
//  MLSTicket.h
//  Realm Create Or Update
//
//  Created by Mike Silvis on 10/7/15.
//  Copyright © 2015 Mike Silvis. All rights reserved.
//

#import <Realm/RLMObject.h>
#import "MSContact.h"

@interface MSTicket : RLMObject

@property (nonatomic, strong) MSContact *contact;
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, strong) NSString *seat;
@property (nonatomic, strong) NSData *pdf;

@end
