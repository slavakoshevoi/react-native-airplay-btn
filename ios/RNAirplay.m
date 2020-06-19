#import "RNAirplay.h"
#import "RNAirplayManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation RNAirplay
@synthesize bridge = _bridge;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(startScan)
{
    printf("init Airplay");
    AVAudioSessionRouteDescription* currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAvailable = false;
    int routeCount = (int)[[currentRoute outputs] count];
    BOOL isSpeaker = ([[[[currentRoute outputs] objectAtIndex:0] portName] isEqualToString:@"Speaker"]);
    if(routeCount > 0 && !isSpeaker) {
        isAvailable = true;
        BOOL isConnected = true;
        for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
            if([output.portType isEqualToString:AVAudioSessionPortAirPlay]) {
                [self sendEventWithName:@"airplayConnected" body:@{@"connected": @(isConnected)}];
            }
        }
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector: @selector(airplayChanged:)
         name:AVAudioSessionRouteChangeNotification
         object:[AVAudioSession sharedInstance]];
    }

    [self sendEventWithName:@"airplayAvailable" body:@{@"available": @(isAvailable)}];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self isAvailable];
    });
}

RCT_EXPORT_METHOD(disconnect)
{
    printf("disconnect Airplay");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self sendEventWithName:@"airplayAvailable" body:@{@"available": @(false) }];
}

RCT_EXPORT_METHOD(showVolume)
{
  printf("Show Volume window");

    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    volumeView.showsVolumeSlider = true;
    [volumeView sizeToFit];
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [viewController.view addSubview:volumeView];

    for ( UIView* subview in volumeView.subviews ) {
        if ( [subview isKindOfClass:[UIButton class]] ) {
            UIButton *button = subview;
          [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }

    [volumeView removeFromSuperview];

}


- (void)airplayChanged:(NSNotification *)sender
{
    AVAudioSessionRouteDescription* currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAirPlayPlaying = false;
    for (AVAudioSessionPortDescription * output in currentRoute.outputs) {
        if([output.portType isEqualToString:AVAudioSessionPortAirPlay]) {
            isAirPlayPlaying = true;
            break;
        }
    }
    [self sendEventWithName:@"airplayConnected" body:@{@"connected": @(isAirPlayPlaying)}];
}


- (void) isAvailable;
{
    printf("init Available");
    AVAudioSessionRouteDescription* currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    BOOL isAvailable = false;
    int routeCount = (int)[[currentRoute outputs] count];
    BOOL isSpeaker = ([[[[currentRoute outputs] objectAtIndex:0] portName] isEqualToString:@"Speaker"]);
    if(routeCount > 0 &&!isSpeaker) {
        isAvailable = true;
    }
    [self sendEventWithName:@"airplayAvailable" body:@{@"available": @(isAvailable)}];
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"airplayAvailable", @"airplayConnected"];
}


@end
