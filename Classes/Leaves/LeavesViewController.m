//
//  LeavesViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//

#import "LeavesViewController.h"
#import "BwcbdMainViewController.h"

@implementation LeavesViewController

- (void) initialize {
   leavesView = [[LeavesView alloc] initWithFrame:CGRectZero];
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
   if (self = [super initWithNibName:nibName bundle:nibBundle]) {
      [self initialize];
   }
   return self;
}

- (id)init {
   return [self initWithNibName:nil bundle:nil];
}

- (void) awakeFromNib {
	[super awakeFromNib];
	[self initialize];
}

- (void)dealloc {
	[leavesView release];
    [super dealloc];
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 0;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	
}

#pragma mark  UIViewController methods

- (void)loadView {
	[super loadView];
	leavesView.frame = self.view.bounds;
	leavesView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:leavesView];
    //path menu
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"story-button.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"story-button-pressed.png"];
    
    // Camera MenuItem.
    QuadCurveMenuItem *menuMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"bookmenu.png"]
                                                         highlightedContentImage:nil];
    // People MenuItem.
    QuadCurveMenuItem *writeMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[UIImage imageNamed:@"write.png"]
                                                         highlightedContentImage:nil];
    // Place MenuItem.
    QuadCurveMenuItem *backMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[UIImage imageNamed:@"back.png"]
                                                        highlightedContentImage:nil];

    
    NSArray *menus = [NSArray arrayWithObjects:menuMenuItem, writeMenuItem, backMenuItem, nil];
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:self.view.bounds menus:menus];
    menu.delegate = self;
    [self.view addSubview:menu];

}

- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    if (idx == 0) {
        BwcbdMainViewController *vc = [[BwcbdMainViewController alloc]initWithItems:LeavesItems LeavesView:leavesView];
        [self presentModalViewController:vc animated:YES];
    }
    else if(idx ==1)
    {
        UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"读书笔记界面" message:@"开发中" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [av show];
    }
    else{
        [self dismissModalViewControllerAnimated:YES];
    }
    NSLog(@"Select the index : %d",idx);
}

- (void) viewDidLoad {
	[super viewDidLoad];
	leavesView.dataSource = self;
	leavesView.delegate = self;
	[leavesView reloadData];
}

-(void)GoToPageIndex:(NSInteger *)index{
    [leavesView setCurrentPageIndex:index];
}
@end
