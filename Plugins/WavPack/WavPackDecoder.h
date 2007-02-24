//
//  WavPackFile.h
//  Cog
//
//  Created by Vincent Spader on 6/6/05.
//  Copyright 2005 Vincent Spader All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Plugin.h"

#import "Wavpack/wputils.h"

@interface WavPackDecoder : NSObject <CogDecoder>
{
	WavpackContext *wpc;
	
	int bitsPerSample;
	int channels;
	int bitrate;
	float frequency;
	double length;
}

@end
