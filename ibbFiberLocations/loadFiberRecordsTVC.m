//
//  loadFiberRecordsTVC.m
//  ibbFiberLocations
//
//  Created by Emrah on 25.03.2014.
//  Copyright (c) 2014 IBB. All rights reserved.
//

#import "loadFiberRecordsTVC.h"

@interface loadFiberRecordsTVC ()

@end

@implementation loadFiberRecordsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.refreshControl beginRefreshing];
    NSURL *url = [NSURL URLWithString:@"http://localhost:9090/fiberRecords.json"];
    
    // create another queue
    dispatch_queue_t fetchQ = dispatch_queue_create("flickr fecther", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                            options:0
                                                                              error:NULL];
        // NSLog(@"Flickr results %@", propertyListResults);
        NSArray *records = [propertyListResults valueForKeyPath:@"records.record"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.refreshControl endRefreshing];
            self.fiberRecords = records;
            NSString* newStr = [[NSString alloc] initWithData:jsonResults encoding:NSUTF8StringEncoding];
            NSLog(@" - %@" ,newStr);
        });
    });
}
@end
