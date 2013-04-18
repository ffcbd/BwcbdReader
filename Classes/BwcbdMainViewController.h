//
//  BwcbdMainViewController.h
//  CBD_book
//
//  Created by dong on 13-4-17.
//
//

#import <UIKit/UIKit.h>
#import "PicFrame.h"
@class LeavesView;
@interface BwcbdMainViewController : UIViewController<UIScrollViewDelegate>{
    NSArray *data;
    NSMutableArray *imageviews;
    NSInteger index;
    BOOL pageControlUsed;
    PicFrame *pf;
}
@property (strong,nonatomic) LeavesView *vc;
@property (retain, nonatomic) IBOutlet UIScrollView *MainImageScrollView;
@property (retain, nonatomic) IBOutlet UIScrollView *smallScrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pagecontrol;
- (IBAction)chagepage:(id)sender;
- (id) initWithItems:(NSArray*) items LeavesView:(LeavesView *)leavesView;
@end
