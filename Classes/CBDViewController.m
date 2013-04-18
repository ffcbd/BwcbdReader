//
//  CBDViewController.m
//  CBD_book
//
//  Created by dong on 13-3-18.
//  Copyright (c) 2013年 dong. All rights reserved.
//

#import "CBDViewController.h"
#import "CBDBookViewController.h"
#import "SFHFKeychainUtils.h"

@interface CBDViewController ()

@end

@implementation CBDViewController
@synthesize text_pass,text_user,text_bus;
@synthesize backItem;
@synthesize bus_no;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    bus_no = @"1";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_sign:(id)sender {
    CBDBookViewController *bvc = [[UINavigationController alloc]initWithRootViewController:[[CBDBookViewController alloc] init]];
    [self presentModalViewController:bvc animated:YES];

//	if(text_user.text.length==0||text_pass.text.length==0)
//	{
//		UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"用户名或密码不能为空" message:@"请键入用户名或密码" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil];
//		[alertView show];
//		[alertView release];
//	}
//	else
//	{
//		//NSLog(@"%@ %@",[SFHFKeychainUtils getPasswordForUsername:user.text andServiceName:@"passwordTest" error:nil],password.text);
//		if([[SFHFKeychainUtils getPasswordForUsername:text_user.text andServiceName:@"CBDpassword" error:nil] isEqual: text_pass.text])
//		{
//            if([text_bus.text compare:bus_no]==NSOrderedSame)
//            {
//                CBDBookViewController *bvc = [[UINavigationController alloc]initWithRootViewController:[[CBDBookViewController alloc] init]];
//                [self presentModalViewController:bvc animated:YES];
//            }
//            else{
//                UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"登陆失败" message:@"企业密钥输入不正确" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil];
//                [alertView show];
//                text_bus.text =@"";
//            }
//		}
//		else
//		{
//			UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"登陆失败" message:@"用户名或密码不正确" delegate:self cancelButtonTitle:@"OK,I know" otherButtonTitles:nil];
//			[alertView show];
//		}
//	}
}



- (void)dealloc {
    [super dealloc];
}
- (void)viewDidUnload {
    [self setText_bus:nil];
    [super viewDidUnload];
}
@end
