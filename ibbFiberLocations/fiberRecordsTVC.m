//
//  fiberRecordsTVC.m
//  ibbFiberLocations
//
//  Created by Emrah on 24.03.2014.
//  Copyright (c) 2014 IBB. All rights reserved.
//

#import "fiberRecordsTVC.h"

@interface fiberRecordsTVC ()

@end

@implementation fiberRecordsTVC

- (void)setFiberRecords:(NSArray *)fiberRecords
{
    _fiberRecords = fiberRecords;
    [self.tableView reloadData];
    
    for (NSString *element in _fiberRecords) {
        NSLog(@" - %@" ,element);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.fiberRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Fiber Records Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *fiberRecords = self.fiberRecords[indexPath.row];
    cell.textLabel.text = [fiberRecords valueForKey:@"pipeType"];
    cell.detailTextLabel.text =  [fiberRecords valueForKey:@"locationType"];
    // image for cell
    //cell.imageView.image = [UIImage imageNamed:@"cover.png"];
    
    return cell;
}


- (void)prepareFiberRecordViewController:(UIViewController *)uvc toDisplayRecord:(NSDictionary *)record
{
    //ivc.imageUrl = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
    //ivc.title = [photo valueForKey:FLICKR_PHOTO_TITLE];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Display Record"]) {
                if ([segue.destinationViewController isKindOfClass:[UIViewController class]]) {
                    [self prepareFiberRecordViewController:(UIViewController *)segue.destinationViewController toDisplayRecord:self.fiberRecords[indexPath.row]];
                }
            }
        }
    }

}
@end
