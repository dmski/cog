//
//  main.m
//  Cog
//
//  Created by Vincent Spader on 5/7/05.
//  Copyright Vincent Spader 2005. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Audio/SingleThreadPlayer/Output.h"
#import "Audio/Utils/Semaphore.h"
#import "Utils/Logging.h"

int main(int argc, char *argv[])
{
//	srandom(time(NULL));
//
//    return NSApplicationMain(argc,  (const char **) argv);
    Output* out = [[Output alloc] init];

    AudioStreamBasicDescription asbd = {
        .mSampleRate = 44100.0,
        .mFormatID = kAudioFormatLinearPCM,
        // .mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked,
        .mFormatFlags = kAudioFormatFlagIsFloat,
        // .mBytesPerPacket = 4,
        .mBytesPerPacket = 4*6,
        .mFramesPerPacket = 1,
        // .mBytesPerFrame = 4,
        .mBytesPerFrame = 4*6,
        .mChannelsPerFrame = 6,
        // .mBitsPerChannel = 16,
        .mBitsPerChannel = 32,
        .mReserved = 0
    };

    AudioChannelLayout layout = {
//        .mChannelLayoutTag = kAudioChannelLayoutTag_Stereo,
        .mChannelLayoutTag = kAudioChannelLayoutTag_AudioUnit_5_1,
        .mChannelBitmap = 0,
        .mNumberChannelDescriptions = 0,
        .mChannelDescriptions = NULL
    };

    AudioChannelLayout* filledLayout = fillChannelLayout(&layout);
    NSLog(@"Filled input layout:");
    NSLog(@"tag = %d", (unsigned int) layout.mChannelLayoutTag);
    NSLog(@"bitmap = %d", (unsigned int) layout.mChannelBitmap);
    NSLog(@"number desc = %d", (unsigned int) layout.mNumberChannelDescriptions);

    for (int i=0; i<layout.mNumberChannelDescriptions; i++) {
        NSLog(@"  desc %d:", i);
        NSLog(@"    label = %d", (unsigned int) layout.mChannelDescriptions[i].mChannelLabel);
        NSLog(@"    flags = %d", (unsigned int) layout.mChannelDescriptions[i].mChannelFlags);
        NSLog(@"    coord = %f %f %f", (float) layout.mChannelDescriptions[i].mCoordinates[0], (float) layout.mChannelDescriptions[i].mCoordinates[1], (float) layout.mChannelDescriptions[i].mCoordinates[2]);
    }

    AudioDeviceID devId = getDefaultDeviceId();

    if ([out setupWithOutputDevice: devId streamFormat:&asbd channelMapping:filledLayout]) {
        ALog(@"Great success");
        [out start];
        Semaphore* s = [[Semaphore alloc] init];
        [s waitIndefinitely];
    } else {
        ALog(@"Not great success");
    }

    return 0;
}
