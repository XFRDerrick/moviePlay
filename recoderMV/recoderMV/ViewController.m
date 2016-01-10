//
//  ViewController.m
//  recoderMV
//
//  Created by 赫腾飞 on 16/1/7.
//  Copyright © 2016年 hetefe. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
@interface ViewController ()<AVCaptureFileOutputRecordingDelegate>

#pragma mark
@property (nonatomic, strong)  AVCaptureMovieFileOutput *outPut ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)begin:(id)sender {
    
    //创建输入对象
    
    //麦克
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    AVCaptureDeviceInput *audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioDevice error:nil];
    
   //摄像头
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:nil];
    
     //创建输出对象
    AVCaptureMovieFileOutput *outPut = [[AVCaptureMovieFileOutput alloc] init];
    
    
    self.outPut = outPut;
    //创建会话链接 输入与输出
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    if ([session canAddInput:videoInput]) {
        [session addInput:videoInput];
    }
    if ([session canAddInput:audioDevice]) {
        [session addInput:audioDevice];
    }
    if ( [session canAddOutput:outPut]) {
        
        [session addOutput:outPut];
    }
    
    
    
    
    
    //添加图
    
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    layer.frame = CGRectMake(0, 200, 200, 200);
    [self.view.layer addSublayer:layer];
    //开始会话
    
    [session startRunning];
    //开始录制
    NSString *path  =[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingPathComponent:@"123.mp4"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    [outPut startRecordingToOutputFileURL:url recordingDelegate:self];
    
}
- (IBAction)stop:(id)sender {
    
    [self.outPut stopRecording];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{

    NSLog(@"11111");

}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    NSLog(@"22222");


}

@end
