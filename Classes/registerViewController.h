//
//  registerViewController.h
//  CBD_book
//
//  Created by dong on 13-3-26.
//
//

#import <UIKit/UIKit.h>
@class CBDViewController;

@interface registerViewController : UIViewController
@property (nonatomic,strong) CBDViewController *vc;
@property (retain, nonatomic) IBOutlet UITextField *user;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UITextField *ensurePassword;
- (IBAction)regButtonPress:(id)sender;
-(void)showAlert;
@end
