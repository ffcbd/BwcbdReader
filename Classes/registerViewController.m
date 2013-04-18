//
//  registerViewController.m
//  CBD_book
//
//  Created by dong on 13-3-26.
//
//

#import "registerViewController.h"
#import "SFHFKeychainUtils.h"
#import "CBDViewController.h"

@interface registerViewController ()

@end

@implementation registerViewController
@synthesize user,password,ensurePassword,vc;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [self setUser:nil];
    [self setPassword:nil];
    [self setEnsurePassword:nil];
    [super viewDidUnload];
}
- (IBAction)regButtonPress:(id)sender {
    
	if(user.text.length==0||password.text.length==0||ensurePassword.text.length==0)
	{
		UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"用户名或密码不能为空" message:@"请键入用户名或密码" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil];
		[alertView show];
	}
	else if([password.text compare:ensurePassword.text]!=NSOrderedSame){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"两次密码输入不一样" message:@"请重新输入密码" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil];
		[alertView show];
    }
    else if([SFHFKeychainUtils getPasswordForUsername:user.text andServiceName:@"CBDpassword" error:nil])
	{
		UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"用户名已存在" message:@"请重新选择用户名" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil];
		[alertView show];
		user.text=nil;
	}
    else
	{
		[SFHFKeychainUtils storeUsername:user.text andPassword:password.text forServiceName:@"CBDpassword" updateExisting:YES error:nil];
		UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil];
		[alertView show];
		CBDViewController *vc = [[CBDViewController alloc]initWithNibName:@"CBDViewController" bundle:nil];
        [self presentModalViewController:vc animated:YES];
        
	}
    
    

    
}
@end
