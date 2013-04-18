//
//  CBDBookViewController.m
//  bs_book
//
//  Created by dong on 13-3-20.
//  Copyright (c) 2013年 dong. All rights reserved.
//
#define ImageHeight 204.8

#import "CBDBookViewController.h"
#import "PopoverController.h"
#import "CBDViewController.h"
#import "EPubViewController.h"
#import "BwcbdReaderViewController.h"

@interface CBDBookViewController ()

@end

@implementation CBDBookViewController
@synthesize scrollView,fileType,imagetype,files;
@synthesize backItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 static int num = 0;
 static int booknum = 0;
 static int epubtype;
 static int bwcbdtype;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //类型初始化
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"filetype" ofType:@"plist"];
    NSDictionary *diction = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    fileType=[diction allKeys];
    imagetype = [diction allValues];
    int i =0;
    for(NSString* type in fileType){
        if([type compare:@".epub"]==NSOrderedSame)
            epubtype = i;
        if ([type compare:@".bwcbd"]==NSOrderedSame) {
            bwcbdtype =i;
        }
        i++;
    }
    
    
    //软件Document文件夹下文件扫描
    
    //    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDir error:nil];
    
//软件根目录下文件扫描
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSMutableArray *tfiles = [[NSMutableArray alloc]init];
//    NSArray *file;
    
    //按照文件类型扫描添加
//    for(int t = 0; t < [fileType count]; t++){
//        file = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS %@",fileType[t]]];
//        [tfiles addObjectsFromArray:file];
//    }

    //按照扫描顺序进行添加
    for(NSString *obj in dirContents){
        for(int t = 0; t < [fileType count]; t++){
        if([obj hasSuffix:fileType[t]])
            [ tfiles addObject:obj];
        }
    }

    files = tfiles;
//    NSLog(@"%@",files);
    //界面绘制
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:248.0/255.0 green:172.0/255.0 blue:37.0/255.0 alpha:1.0];
    
    [self.navigationController addBackgroundView:@"1.png"];
    
	UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"同步"
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(syncing)];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"登出"
                                      style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(signout)];
    
//    UIBarButtonItem *leftBarButton1 = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(dele)];
//    UIBarButtonItem *leftBarButton2 = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    
	self.navigationItem.rightBarButtonItem = rightBarButton;
    
//    NSArray *btn = [[NSArray alloc]initWithObjects:leftBarButton,leftBarButton1,leftBarButton2, nil];
    self.navigationItem.leftBarButtonItem =leftBarButton;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 960)];
    scrollView.contentSize=CGSizeMake(768,1024);
    
    //设置背景
    UIImage *backimg=[UIImage imageNamed:@"3.png"];
    UIImageView *backview=[[UIImageView alloc] initWithImage:backimg];
    backview.frame=CGRectMake(0, 0, 768,1024);
    [self.view addSubview:backview];
    [self.view addSubview:scrollView];
    
    [self reloadView];
    [self add];
    [self sync];

}

//添加一个书架
-(void)add{
    
    num++;
    
    UIImage *backimg=[UIImage imageNamed:@"2.png"];
    UIImageView *backview=[[UIImageView alloc] initWithImage:backimg];
    backview.frame=CGRectMake(0, (num-1)*ImageHeight, 768, ImageHeight);
    backview.tag = num+100;
    backview.userInteractionEnabled = YES;
    [scrollView addSubview:backview];
    
    if (num>5) {
        scrollView.contentSize=CGSizeMake(768,num*ImageHeight);
    }
   
}

-(void)syncing{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"同步中..." message:@"请稍后" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [av show];
    
}
    
//删除一个书架
-(void)dele{
    if (num<=0) {
        return;
    }

    for (UIView *view in scrollView.subviews) {
        if(view.tag == (num+100))
            [view removeFromSuperview];
    }
    
    num--;
    
    if (num>3) {
        scrollView.contentSize=CGSizeMake(768,num*ImageHeight);
    }
}

//删除图书
-(void)dele_book{
    UIButton *btn = [scrollView.subviews[0] viewWithTag:booknum];
    [btn removeFromSuperview];
    booknum--;
}

//打开文件
-(void)open:(UIButton *) sender{
    NSString *name = [files objectAtIndex:sender.tag/10-1];
    int type = sender.tag%10;
    if (type == epubtype) {
//        NSLog(@"%@",name);
        EPubViewController *vc = [[EPubViewController alloc]init];
        [vc loadEpub:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:nil]]];
        [self presentModalViewController:vc animated:YES];
    }
    else if(type == bwcbdtype){
        BwcbdReaderViewController *vc = [[BwcbdReaderViewController alloc]init];
        NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
        [vc loadBwcbd:url];
        [self presentModalViewController:vc animated:YES];
    }
    else{
        NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
        UIDocumentInteractionController *docInter = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        docInter.delegate = self;
        [docInter retain];
        [docInter presentOpenInMenuFromRect:CGRectMake(0, 200, 320, 400) inView:self.view animated:YES];
    }
}


//主界面初始化
-(void)reloadView{
    
    NSLog(@"reloadView");
    //遍历当前界面的所有子界面，把子界面删除干净
    for(UIView *view in scrollView.subviews){
        [view removeFromSuperview];
    }
    
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.delegate=self;
    [scrollView setScrollEnabled:YES];
    
}


//同步
-(void)sync{
    int i =0;
    int shujia = 0;
    booknum=0;
    for (NSString* obj in files)
    {
        i++;
        booknum++;
        if(i>3){
            i=1;
            [self add];
            shujia++;
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect btnFrame = CGRectMake(50+270*(i-1), 5, 130, ImageHeight-40);
        btn.frame =btnFrame;
        int t=0;
        for(NSString* type in fileType){
            if([obj hasSuffix:type]){
                btn.tag = (shujia*3+i)*10+t;
                [btn setBackgroundImage:[UIImage imageNamed:imagetype[t]] forState:UIControlStateNormal];
                [btn  addTarget:self action:@selector(open:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:obj forState:UIControlStateNormal];
            }
            t++;
        }
        btn.contentVerticalAlignment=UIControlContentVerticalAlignmentBottom;
        [self.scrollView.subviews[shujia] addSubview:btn];
    }
}

//登出
-(void)signout{
    num=0;
    CBDViewController *vc = [[CBDViewController alloc]initWithNibName:@"CBDViewController" bundle:nil];
    [self presentModalViewController:vc animated:YES];
}

//控制滚动视图的滚动！！！
#pragma mark UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
