//
//  FileIcon.h
//  Cog
//
//  Created by Vincent Spader on 8/20/06.
//  Copyright 2006 Vincent Spader. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PathIcon : NSObject {
	NSString *path;
	NSImage *icon;
}

-(id)initWithPath:(NSString *)p;

@end
