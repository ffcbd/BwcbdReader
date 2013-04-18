//
//  Bwcbd.m
//  CBD_book
//
//  Created by dong on 13-4-16.
//
//

#import "Bwcbd.h"
#import "ZipArchive.h"
#import "TouchXML.h"

@interface Bwcbd()

- (void) parseBwcbd;
- (void) unzipAndSaveFileNamed:(NSString*)fileName;
- (NSString*) applicationDocumentsDirectory;
- (NSString*) parseFilePath;
- (NSArray*) parseItems:(NSString*)itemsPath;

@end

@implementation Bwcbd
@synthesize spineArray;

- (id) initWithBwcbdPath:(NSString*)path{
    if((self=[super init])){
		bwcbdFilePath = path;
		spineArray = [[NSMutableArray alloc] init];
		[self parseBwcbd];
	}
	return self;
}

- (void) parseBwcbd{
    
	[self unzipAndSaveFileNamed:bwcbdFilePath];
    NSFileManager *manage=[NSFileManager defaultManager];
    NSArray *files=[manage subpathsAtPath:[NSString stringWithFormat:@"%@/UnzippedBwcbd", [self applicationDocumentsDirectory]]];
//    NSLog(@"%@",files);
	 NSString* Path = [self parseFilePath];
//    NSLog(@"%@",Path);
     spineArray = [self parseItems:Path];
}

- (void)unzipAndSaveFileNamed:(NSString*)fileName{
	
	ZipArchive* za = [[ZipArchive alloc] init];
//    	NSLog(@"%@", fileName);
//    	NSLog(@"unzipping %@", bwcbdFilePath);
	if( [za UnzipOpenFile:bwcbdFilePath]){
		NSString *strPath=[NSString stringWithFormat:@"%@/UnzippedBwcbd",[self applicationDocumentsDirectory]];
//        		NSLog(@"%@", strPath);
		//Delete all the previous files
		NSFileManager *filemanager=[[NSFileManager alloc] init];
		if ([filemanager fileExistsAtPath:strPath]) {
			NSError *error;
			[filemanager removeItemAtPath:strPath error:&error];
		}
		[filemanager release];
		filemanager=nil;
		//start unzip
		BOOL ret = [za UnzipFileTo:[NSString stringWithFormat:@"%@/",strPath] overWrite:YES ];
		if( NO==ret ){
			// error handler here
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error"
														  message:@"Error while unzipping the bwcbd"
														 delegate:self
												cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
			[alert show];
			alert=nil;
		}
		[za UnzipCloseFile];
	}
}

- (NSString*) parseFilePath{
    NSString* FilePath = [NSString stringWithFormat:@"%@/UnzippedBwcbd/container.xml", [self applicationDocumentsDirectory]];
    // using local resource file
    NSData *XMLData = [NSData dataWithContentsOfFile:FilePath];
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:XMLData options:0 error:nil];
    NSArray *nodes = NULL;
    // searching for piglet nodes
    nodes = [doc nodesForXPath:@"//rootfiles" error:nil];
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    for (CXMLElement *node in nodes) 
            [item setObject:[[node childAtIndex:1] stringValue] forKey:[[node childAtIndex:1] name]];
    return [item objectForKey:@"path"] ;
    
}

- (NSArray*) parseItems:(NSString*)itemsPath{
    NSString* FilePath = [NSString stringWithFormat:@"%@/UnzippedBwcbd/%@", [self applicationDocumentsDirectory],itemsPath];
    NSData *XMLData = [NSData dataWithContentsOfFile:FilePath];
    CXMLDocument *doc = [[[CXMLDocument alloc] initWithData:XMLData options:0 error:nil] autorelease];
    
    NSArray *nodes = NULL;
    // searching for piglet nodes
    nodes = [doc nodesForXPath:@"//item" error:nil];
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    NSMutableArray *items =[[NSMutableArray alloc]init];
    for (CXMLElement *node in nodes) {
        int counter;
        for(counter = 0; counter < [node childCount]; counter++) {
            NSString * value = [[[node childAtIndex:counter] stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if ([value length] != 0){
                [item setObject:[[node childAtIndex:counter] stringValue] forKey:[[node childAtIndex:counter] localName]];
            }            
        }
        NSString *itemadd = [NSString stringWithFormat:@"%@/UnzippedBwcbd/items/%@",[self applicationDocumentsDirectory],[item objectForKey:@"image"]];
        [items addObject:itemadd];
    }
    
    // and we print our results
    return items;
}

- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}



@end
