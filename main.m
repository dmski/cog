//
//  main.m
//  Cog
//
//  Created by Vincent Spader on 5/7/05.
//  Copyright Vincent Spader 2005. All rights reserved.
//

#import <Cocoa/Cocoa.h>

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
