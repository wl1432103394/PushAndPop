//
//  ViewController.m
//  PushAndPop
//
//  Created by 王力 on 16/9/5.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AViewController () <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechUtterance *utterance; //语音表达
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer; //语音合成
@property (nonatomic, strong) UITextField *textField;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 49)];
    self.textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textField];
    
    UIButton *eButton = [UIButton buttonWithType:UIButtonTypeCustom];
    eButton.frame = CGRectMake(100, 300, 100, 100);
    [eButton setTitle:@"A" forState:UIControlStateNormal];
    [eButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [eButton addTarget:self action:@selector(PushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eButton];
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.frame = CGRectMake(100, 100, 100, 100);
    [aButton setTitle:@"语音合成" forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
    
    UIButton *bButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bButton.frame = CGRectMake(200, 200, 100, 100);
    [bButton setTitle:@"停止" forState:UIControlStateNormal];
    [bButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bButton addTarget:self action:@selector(stopSpeekingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bButton];
    
    UIButton *cButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cButton.frame = CGRectMake(100, 200, 100, 100);
    [cButton setTitle:@"暂停" forState:UIControlStateNormal];
    [cButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cButton addTarget:self action:@selector(pauseSpeekingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cButton];
    
//    UIButton *dButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    dButton.frame = CGRectMake(100, 300, 100, 100);
//    [dButton setTitle:@"继续" forState:UIControlStateNormal];
//    [dButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [dButton addTarget:self action:@selector(continueSpeekingAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:dButton];
    
    //continueSpeaking
}

- (void)PushAction:(UIButton *)sender {
    BViewController *B = [[BViewController alloc] init];
    [self.navigationController pushViewController:B animated:YES];
}

//- (void)continueSpeekingAction:(UIButton *)sender {
//    if ([self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate]) {
//        [self.synthesizer continueSpeaking];
//    }
//}

// 暂停\继续
- (void)pauseSpeekingAction:(UIButton *)sender {
    NSString *btnTitle = sender.titleLabel.text;
    if ([btnTitle isEqualToString:@"暂停"]) {
        if ([self.synthesizer isSpeaking]) {//是否正在合成之后的表达
            [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];//暂停
            [sender setTitle:@"继续" forState:UIControlStateNormal];
        }
    } else {
        //是否处于暂停状态
        if ([self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate]) {
            [self.synthesizer continueSpeaking];//继续表达
            [sender setTitle:@"暂停" forState:UIControlStateNormal];
        }
    }
}
//停止
- (void)stopSpeekingAction:(UIButton *)sender {
    if ([self.synthesizer isSpeaking]) {//是否正在表达
        [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];//停止
    }
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"A:%@", self.navigationController.viewControllers);
    
}
- (void)buttonAction:(UIButton *)sender {
    [self.textField resignFirstResponder];
//    BViewController *B = [[BViewController alloc] init];
//    [self.navigationController pushViewController:B animated:YES];
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];  //初始化语音合成者
    self.synthesizer.delegate = self;                       //代理
    //初始化语音表达类 设置语音文字
    self.utterance = [AVSpeechUtterance speechUtteranceWithString:self.textField.text];
    self.utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CH"];//设置语言
    self.utterance.rate = 0.4; //设置语速
    [self.synthesizer speakUtterance:self.utterance];//合成语音并表达
    NSLog(@"%@", [AVSpeechSynthesisVoice speechVoices]);//获取语言类型
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
    NSLog(@"characterRange:%@", NSStringFromRange(characterRange));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
