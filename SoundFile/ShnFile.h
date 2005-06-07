//
//  ShnFile.h
//  Cog
//
//  Created by Zaphod Beeblebrox on 6/6/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SoundFile.h"

#import "Shorten/shorten.h"
#import "Shorten/shn.h"
#import "Shorten/decode.h"

@interface ShnFile : SoundFile {
	shn_file *handle;
	
	int bufferSize; //total size
	void *buffer;
	int bufferAmount; //amount currently in
}

@end