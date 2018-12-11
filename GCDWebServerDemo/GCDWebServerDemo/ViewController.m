//
//  ViewController.m
//  GCDWebServerDemo
//
//  Created by sytz on 2018/12/10.
//  Copyright © 2018年 sytz. All rights reserved.
//

#import "ViewController.h"
#import <GCDWebUploader.h>
#import "SSZipArchive.h"
@interface ViewController ()
@property (nonatomic,strong) GCDWebUploader *webUploader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    docuPath = [NSString stringWithFormat:@"%@/new",docuPath];
    if (![fileManager fileExistsAtPath:docuPath]) {
        [fileManager createDirectoryAtPath:docuPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *testSrt = @"new";
    //[testSrt writeToFile:[NSString stringWithFormat:@"%@/test.txt",docuPath]  atomically:YES];
    [testSrt writeToFile:[NSString stringWithFormat:@"%@/test.txt",docuPath]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/new",NSHomeDirectory()];
    NSString *goalPath = [NSString stringWithFormat:@"%@/Documents/new.zip",NSHomeDirectory()];
    [SSZipArchive createZipFileAtPath:goalPath withContentsOfDirectory:filePath];
}
- (IBAction)startGCDWebServer:(id)sender {
    if (_webUploader == nil) {
        self.webUploader = [[GCDWebUploader alloc]initWithUploadDirectory:[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()]];
        self.webUploader.allowHiddenItems = YES;
        self.webUploader.allowedFileExtensions = @[@"doc",@"docx",@"xls",@"xlsx",@"txt",@"pdf",@"png",@"jpg",@"plist",@"zip",@"jpeg"];
        self.webUploader.title = @"M the Title";
        self.webUploader.prologue = @"M the prologue";
        self.webUploader.epilogue = @"M the epilogue";
    }
    if ([_webUploader start]) {
        NSString *str = [NSString stringWithFormat:@"Server is connected,please open:%@ by your broswer",_webUploader.serverURL];
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Warning" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Disconnect" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self->_webUploader stop];
        }];
        [alertView addAction:doneAction];
        [self presentViewController:alertView animated:YES completion:nil];
    }
    
}


@end
