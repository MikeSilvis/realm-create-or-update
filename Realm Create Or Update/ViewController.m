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
#import <Realm/Realm.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *objectId = @"123";

    RLMRealm *realmOne = [RLMRealm defaultRealm];

    // Create a new ticket
    MSTicket *ticketOne = [MSTicket new];
    ticketOne.objectID = objectId;
    ticketOne.seat = @"2";

    [realmOne transactionWithBlock:^{
        [MSTicket createOrUpdateInDefaultRealmWithValue:ticketOne];
    }];

    // Verify seat and id are stored
    MSTicket *dbTicketOne = [MSTicket objectForPrimaryKey:objectId];
    NSLog(@"initial creation and find of ticket objectID: %@ withSeat: %@", dbTicketOne.objectID, dbTicketOne.seat);

    // Create a new ticket with the same objectID but no seat
    MSTicket *ticketTwo = [MSTicket new];
    ticketTwo.objectID = objectId;

    [realmOne transactionWithBlock:^{
        [MSTicket createOrUpdateInDefaultRealmWithValue:ticketTwo];
    }];

    // Seat is still found and persisted
    MSTicket *dbTicketTwo = [MSTicket objectForPrimaryKey:objectId];
    NSLog(@"Verify seat is still persisted even though we didnt add it again objectID: %@ seat: %@", dbTicketTwo.objectID, dbTicketTwo.seat);

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.discretionary = YES;

    NSURL *URL = [NSURL URLWithString:@"https://cloudsecurityalliance.org/csaguide.pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        RLMRealm *realmTwo = [RLMRealm defaultRealm];
        NSData *myFile = [NSData dataWithContentsOfURL:location];

        // Add PDF to db object
        MSTicket *dbTicketThree = [MSTicket objectForPrimaryKey:objectId];
        [realmTwo transactionWithBlock:^{
            dbTicketThree.pdf = myFile;

            [MSTicket createOrUpdateInDefaultRealmWithValue:dbTicketThree];
        }];

        // Find a new db object and see the pdf is stored
        MSTicket *dbTicketFour = [MSTicket objectForPrimaryKey:objectId];
        NSLog(@"after we added a PDF to the ticket: %@ seat: %@ length: %lu", dbTicketFour.objectID, dbTicketFour.seat, (unsigned long)dbTicketFour.pdf.length);

        // Create a random new object & save
        MSTicket *ticketThree = [MSTicket new];
        ticketThree.objectID = objectId;

        [realmTwo transactionWithBlock:^{
            [MSTicket createOrUpdateInDefaultRealmWithValue:ticketThree];
        }];

        // Now fetch it and pdf is gone
        MSTicket *dbTicketFive = [MSTicket objectForPrimaryKey:objectId];
        NSLog(@"Now that we created and saved a new obj %@ seat: %@ and pdf %lu", dbTicketFive.objectID, dbTicketFive.seat, (unsigned long)dbTicketFive.pdf.length);
    }];

    [downloadTask resume];
}

@end
