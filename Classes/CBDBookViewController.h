//
//  CBDBookViewController.h
//  bs_book
//
//  Created by dong on 13-3-20.
//  Copyright (c) 2013年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBDBookViewController : UIViewController <UIScrollViewDelegate,UIDocumentInteractionControllerDelegate>{
    UIScrollView *scrollView;
}

@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSArray *fileType;
@property(nonatomic,strong) NSArray *imagetype;
@property(nonatomic,strong) NSArray *files;
@property (nonatomic,strong)UIBarButtonItem *backItem;

-(void)add;
-(void)dele;
-(void)reloadView;
-(void)sync;
-(void)syncing;
-(void)signout;
-(void)open:(UIButton *) sender;
-(void)dele_book;
@end
