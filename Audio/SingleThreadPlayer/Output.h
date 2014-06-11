#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

AudioChannelLayout* fillChannelLayout(AudioChannelLayout* pLayout);
AudioDeviceID getDefaultDeviceId();

@interface Output : NSObject {
    AUGraph auGraph;
    AudioUnit outputUnit;
    AudioStreamBasicDescription* currentInFormat;
    AudioChannelLayout* currentInChannelLayout;

    @public Float32 time;
}

- (BOOL) setupWithOutputDevice:(AudioDeviceID) deviceId
                  streamFormat:(AudioStreamBasicDescription*) format
                channelMapping:(AudioChannelLayout*) channelLayout;

- (BOOL) start;

- (BOOL) stop;

- (BOOL) isRunning;

- (BOOL) setVolume:(double)vol;
@end