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

    [realm beginWriteTransaction];
    [realm addObject:contact];
    [realm commitWriteTransaction];

    MSTicket *ticket = [MSTicket new];
    ticket.objectID = @"abc";
    MSContact *contact2 = [MSContact new];
    contact2.objectID = @"123";
    ticket.contact = contact2;

    [realm beginWriteTransaction];
    [MSTicket createOrUpdateInDefaultRealmWithValue:ticket];
    [realm commitWriteTransaction];
}

@end
