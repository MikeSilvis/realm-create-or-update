//
//  ViewController.m
//  Realm Create Or Update
//
//  Created by Mike Silvis on 10/7/15.
//  Copyright © 2015 Mike Silvis. All rights reserved.
//

#import "ViewController.h"
#import "MSContact.h"
#import "MSTicket.h"
#import <Realm.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RLMRealm *realm = [RLMRealm defaultRealm];

    MSContact *contact = [MSContact new];
    contact.objectID = @"123";

    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:contact];
    }];

    MSTicket *ticket = [MSTicket new];
    ticket.objectID = @"abc";

    [realm transactionWithBlock:^{
        [MSTicket createOrUpdateInDefaultRealmWithValue:ticket];
    }];

    MSTicket *ticket2 = [MSTicket objectForPrimaryKey:@"abc"];
    MSContact *contact2 = [MSContact new];
    contact2.objectID = @"123";

    [realm transactionWithBlock:^{
        ticket2.seat = @"123";
        ticket2.contact = contact2;

        [MSTicket createOrUpdateInDefaultRealmWithValue:ticket2];
    }];

    NSLog(@"ticket id: %@", ticket);
}

@end
