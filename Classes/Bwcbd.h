//
//  Bwcbd.h
//  CBD_book
//
//  Created by dong on 13-4-16.
//
//

#import <Foundation/Foundation.h>

@interface Bwcbd : NSObject{
	NSArray* spineArray;
	NSString* bwcbdFilePath;
}

@property(nonatomic, strong) NSArray* spineArray;

- (id) initWithBwcbdPath:(NSString*)path;

@end
