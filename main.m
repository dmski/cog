//
//  main.m
//  Cog
//
//  Created by Vincent Spader on 5/7/05.
//  Copyright Vincent Spader 2005. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Input.h"
#import "SingleThreadPlayer.h"
#import "Audio/Utils/Semaphore.h"

@interface DummyPlayer : NSObject <InputDelegate, OutputDelegate> {
    Input* input;
}
@end

@implementation DummyPlayer
- (void)inputReady:(Input *)sender {
    NSLog(@"Input ready");
    input = sender;
}

- (void)inputEofReached:(Input *)sender {
    NSLog(@"Input eof reached");
}

- (void)inputExited:(Input *)sender {
    NSLog(@"Input exited");
}


- (AudioDeviceID)outputGetDeviceId {
    UInt32 size = sizeof(AudioDeviceID);
    AudioDeviceID defaultDeviceId;
    AudioObjectPropertyAddress addr = {
            .mSelector = kAudioHardwarePropertyDefaultOutputDevice,
            .mScope = kAudioObjectPropertyScopeGlobal,
            .mElement = kAudioObjectPropertyElementMaster
    };

    OSStatus err = AudioObjectGetPropertyData(kAudioObjectSystemObject, &addr, 0, NULL, &size, &defaultDeviceId);
    if (err != noErr) {
        NSLog(@"Can't get default device id: err = %d", (int) err);
        return (AudioDeviceID) -1;
    }

    return defaultDeviceId;
}

- (const AudioStreamBasicDescription *)outputGetFormat {
    return [input format];
}

- (const AudioChannelLayout *)outputGetChannelLayout {
    return [input channelLayout];
}

- (int)outputReadAudio:(void *)ptr frameCount:(int)frameCount {
    VirtualRingBuffer* buf = [input buffer];
    void* bufPtr = NULL;
    int bytesToRead = frameCount * [input format]->mBytesPerFrame;

    int available = [buf lengthAvailableToReadReturningPointer:&bufPtr];
    if (bytesToRead > available) {
        bytesToRead = available;
    }

//    char* pb = (char*) bufPtr;
//    for (int i=0; i<bytesToRead; i+=105) {
//        NSLog(@"buf[%d] = %d", i, (int) pb[i]);
//    }

    memcpy(ptr, bufPtr, bytesToRead);
    [buf didReadLength:bytesToRead];
    [input unpause];

//    NSLog(@"Read %d bytes, available = %d", bytesToRead, available);

    return bytesToRead;
}

@end

int main(int argc, char *argv[])
{
	srandom(time(NULL));

    return NSApplicationMain(argc,  (const char **) argv);

//    Semaphore* sem = [[Semaphore alloc] init];
//    NSURL* url = [NSURL fileURLWithPath:@"/Users/dima/Music/Mzk/443080_vibe_w2gh.mp3"];
//    DummyPlayer* player = [[DummyPlayer alloc] init];
//
//    Input* input = [[Input alloc] init];
//    [input startWithUrl:url player:player];
//
//    while (![input ready]) {
//        NSLog(@"Not ready");
//    }
//
//    Output* output = [[Output alloc] init];
//    [output setupWithPlayer:player];
//    [output start];
//    [output setVolume:100];
//
//    [sem waitIndefinitely];
//
//    return 0;
}
