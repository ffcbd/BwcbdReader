//
//  CBDViewController.h
//  CBD_book
//
//  Created by dong on 13-3-18.
//  Copyright (c) 2013年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBDViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *text_user;
@property (strong, nonatomic) IBOutlet UITextField *text_pass;
@property (retain, nonatomic) IBOutlet UITextField *text_bus;
@property (nonatomic,retain)UIBarButtonItem *backItem;
@property(strong,nonatomic) NSString *bus_no;
- (IBAction)btn_sign:(id)sender;




@end
