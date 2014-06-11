//
// Created by Dmitry Promsky on 04/06/14.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudio.h>
#import "VirtualRingBuffer.h"
#import "Plugin.h"


@interface Input : NSObject
{
    id<CogDecoder> decoder;
    VirtualRingBuffer *buffer;
}

- (void) initWithUrl:(NSURL*) url;
- (const AudioStreamBasicDescription*) format;
- (const AudioChannelLayout*) channelLayout;
- (void) seek: (long)frame;
@end