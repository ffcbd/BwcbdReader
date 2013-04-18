//
//  BwcbdReaderViewController.m
//  CBD_book
//
//  Created by dong on 13-4-16.
//
//

#import "BwcbdReaderViewController.h"
#import "Utilities.h"

@implementation BwcbdReaderViewController
@synthesize loadedBwcbd;


- (id)init {
    if (self = [super init]) {
		
    }
    return self;
}

- (void) loadBwcbd:(NSURL*) bwcbdURL{
    self.loadedBwcbd = [[Bwcbd alloc] initWithBwcbdPath:[bwcbdURL path]];
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (NSString *imagePath in loadedBwcbd.spineArray) {
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
        [temp addObject:image];
    }
    items = temp;
    LeavesItems = items;
    NSLog(@"load");
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return items.count;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	UIImage *image = [items objectAtIndex:index];
	CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
	CGAffineTransform transform = aspectFit(imageRect,
											CGContextGetClipBoundingBox(ctx));
	CGContextConcatCTM(ctx, transform);
	CGContextDrawImage(ctx, imageRect, [image CGImage]);
}



@end
