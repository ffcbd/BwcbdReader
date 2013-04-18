//
//  BwcbdMainViewController.m
//  CBD_book
//
//  Created by dong on 13-4-17.
//
//

#import "BwcbdMainViewController.h"
#import "LeavesView.h"

@interface BwcbdMainViewController ()

@end

@implementation BwcbdMainViewController
@synthesize MainImageScrollView,smallScrollView,pagecontrol,vc;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithItems:(NSArray*) items LeavesView:(LeavesView *)leavesView{
    if((self=[super init])){
        data = items;
        vc = leavesView;
	}
	return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    index = 0;
    imageviews = [[NSMutableArray alloc] initWithCapacity:[data count]];
    self.MainImageScrollView.delegate = self;
    self.MainImageScrollView.pagingEnabled = YES;
    self.MainImageScrollView.showsHorizontalScrollIndicator = NO;
    CGSize size = MainImageScrollView.frame.size;
    for (int i=0; i < [data count]; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(184+size.width * i, 0, 400, size.height)];
        [iv setImage:[data objectAtIndex:i]];
        [self.MainImageScrollView addSubview:iv];
        iv = nil;
    }
    [self.MainImageScrollView setContentSize:CGSizeMake(size.width*[data count], size.height)];
	for (int i=0; i<[data count]; i++) {
        int row = i/3;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10+270*(i%3), 5+(270) * row, 200, 250)];
        [iv setImage:[data objectAtIndex:i]];
        self.smallScrollView.contentSize=CGSizeMake(768,270*(i/3+1));
        [self.smallScrollView addSubview:iv];
        [imageviews addObject:iv];
        iv = nil;
    }
    pf = [[PicFrame alloc] initWithFrame:((UIImageView*)[imageviews objectAtIndex:index]).frame];
    NSLog(@"frame:%f,%f,%f,%f",pf.frame.size.width,pf.frame.size.height,pf.frame.origin.x,pf.frame.origin.y);
    [self.smallScrollView addSubview:pf];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    
    [self.MainImageScrollView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *smallImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    [smallImageTap setNumberOfTapsRequired:1];
    [self.smallScrollView addGestureRecognizer:smallImageTap];
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
    [self setMainImageScrollView:nil];
    [self setSmallScrollView:nil];
    [self setPagecontrol:nil];
    [self setPagecontrol:nil];
    [super viewDidUnload];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark-- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pagecontrol.currentPage = page;
    index = page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    pageControlUsed = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
    pf.frame = ((UIImageView*)[imageviews objectAtIndex:index]).frame;
    [pf setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [pf setAlpha:.85f];
    }];
}
- (IBAction)chagepage:(id)sender {
    int page = pagecontrol.currentPage;
    index = page;
	
    CGRect frame = MainImageScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [MainImageScrollView scrollRectToVisible:frame animated:YES];
    
    pageControlUsed = YES;
    pf.frame = ((UIImageView*)[imageviews objectAtIndex:index]).frame;
    [pf setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [pf setAlpha:.85f];
    }];
    
}
- (void) handleSingleTap:(UITapGestureRecognizer *) gestureRecognizer{
    CGFloat pageWith = 768;
    
    CGPoint loc = [gestureRecognizer locationInView:MainImageScrollView];
    NSInteger touchIndex = floor(loc.x / pageWith) ;
    if (touchIndex > [data count]-1) {
        return;
    }
    [vc setCurrentPageIndex:touchIndex];
    [self dismissModalViewControllerAnimated:YES];

}
- (void) handleImageTap:(UITapGestureRecognizer *) gestureRecognizer{
    CGFloat rowHeight = 270;
    CGFloat columeWith = 270;
    CGFloat gap = 5;
    
    CGPoint loc = [gestureRecognizer locationInView:smallScrollView];
    NSInteger touchIndex = floor(loc.x / (columeWith + gap)) + 3 * floor(loc.y / (rowHeight + gap)) ;
    if (touchIndex > [data count]-1) {
        return;
    }
    index = touchIndex;
    pagecontrol.currentPage = index;
    CGRect frame = MainImageScrollView.frame;
    frame.origin.x = frame.size.width * touchIndex;
    frame.origin.y = 0;
    [MainImageScrollView scrollRectToVisible:frame animated:NO];
    
    pageControlUsed = YES;
    pf.frame = ((UIImageView*)[imageviews objectAtIndex:index]).frame;
    [pf setAlpha:0];
    [UIView animateWithDuration:0.2f animations:^(void){
        [pf setAlpha:.85f];
    }];
    NSLog(@"small image touch index %d",touchIndex);
}

@end
