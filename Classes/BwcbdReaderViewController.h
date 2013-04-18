//
//  BwcbdReaderViewController.h
//  CBD_book
//
//  Created by dong on 13-4-16.
//
//

#import <UIKit/UIKit.h>
#import "LeavesViewController.h"
#import "Bwcbd.h"

@interface BwcbdReaderViewController : LeavesViewController{
    NSArray *items;
}

@property (nonatomic, strong) Bwcbd* loadedBwcbd;

@end
