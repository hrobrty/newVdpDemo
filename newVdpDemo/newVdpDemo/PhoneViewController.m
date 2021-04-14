//
//  PhoneViewController.m
//  LinPhoneDemo
//
//  Created by louis on 18/08/08.
//  Copyright (c) 2018年 louis. All rights reserved.
//

#import "PhoneViewController.h"
#import "Utilities.h"

PhoneBridge *pb;
LinphoneCall *call;

@implementation PhoneViewController

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.frame = CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, (267));
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 367);
}

#pragma --mark viewlife
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registrationUpdate:) name:kLinphoneRegistrationUpdate object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(callUpdate:) name:kLinphoneCallUpdate object:nil];
    
    //注册状态
    LinphoneProxyConfig* config = NULL;
    linphone_core_get_default_proxy([LinphoneManager getLc], &config);
    [self proxyConfigUpdate: config];
    
     linphone_core_set_native_video_window_id([LinphoneManager getLc], (unsigned long)_videoView);
    
    // 分支测试branch
    // 在release分支上开出分支feat/ble_dev开发蓝牙
    // 版本v1.0.0 后续开发操作
    _username.delegate = self;
    _username.returnKeyType = UIReturnKeyDone;
    _password.delegate = self;
    _password.returnKeyType = UIReturnKeyDone;
    _calleeNumber.delegate = self;
    _calleeNumber.returnKeyType = UIReturnKeyDone;
    
    //add start 
    pb = [PhoneBridge new];
    linphone_core_enable_mic([LinphoneManager getLc], FALSE);
    LinphoneCore* lc = [LinphoneManager getLc];
    linphone_core_enable_video(lc,YES,YES);
    
//    LinphoneCallParams* lcallParams = linphone_core_create_default_call_parameters([LinphoneManager getLc]);
//    linphone_call_params_set_video_direction(lcallParams, LinphoneMediaDirectionRecvOnly);

    //add end
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注册更新
- (void)registrationUpdate: (NSNotification* ) notif {
    LinphoneProxyConfig* config = NULL;
    linphone_core_get_default_proxy([LinphoneManager getLc], &config);
    [self proxyConfigUpdate:config];
}
//代理配置更新
- (void)proxyConfigUpdate: (LinphoneProxyConfig*) config {
    LinphoneRegistrationState state = LinphoneRegistrationNone;
    NSString* message = nil;
    LinphoneCore* lc = [LinphoneManager getLc];
    LinphoneGlobalState gstate = linphone_core_get_global_state(lc);
    
    if( gstate == LinphoneGlobalConfiguring ){
        message = @"状态:获取远程配置";
    } else if (config == NULL) {
        state = LinphoneRegistrationNone;
        if(linphone_core_is_network_reachable([LinphoneManager getLc])){
            message = @"状态:sip账号不存在";
        }else{
            message = @"状态:网络连接失败";
        }
    } else {
        state = linphone_proxy_config_get_state(config);
        
        switch (state) {
            case LinphoneRegistrationOk:
                message = @"状态:注册成功"; break;
            case LinphoneRegistrationNone:
            case LinphoneRegistrationCleared:
                message =  @"状态:未注册"; break;
            case LinphoneRegistrationFailed:
                message =  @"状态:注册失败"; break;
            case LinphoneRegistrationProgress:
                message =  @"状态:注册中……"; break;
            default: break;
        }
    }
    NSLog(@"proxyConfigUpdate regist msg:%@",message);
    [self.statusLabel setText:message];
}

#pragma --mark phone status
//呼叫更新
- (void)callUpdate:(NSNotification*)notif {
    call = [[notif.userInfo objectForKey: @"call"] pointerValue];
    LinphoneCallState state = [[notif.userInfo objectForKey: @"state"] intValue];
    NSString *message = [notif.userInfo objectForKey: @"message"];
    
    NSLog(@"lll=================callUpdateMsg：%@",message);
    
    //    linphone_core_get_calls([LinphoneManager getLc]);
    switch (state) {
        case LinphoneCallIncomingReceived:{
            NSLog(@"lll=================LinphoneCallIncomingReceived");
            break;
        }
        case LinphoneCallIncomingEarlyMedia:{
            linphone_core_set_ring_during_incoming_early_media([LinphoneManager getLc],YES);
//            AudioServicesPlaySystemSound([LinphoneManager instance].sounds.vibrate);
            linphone_core_enable_mic([LinphoneManager getLc], FALSE);

//            if ([UIApplication sharedApplication].applicationState ==  UIApplicationStateActive) {
//                [self acceptCallFromPeer:call];
//            }
            
            NSLog(@"lll=================LinphoneCallIncomingEarlyMedia");
            break;
        }
        case LinphoneCallOutgoingInit:{
            NSLog(@"lll=================LinphoneCallOutgoingInit");
            break;
        
        }
        case LinphoneCallPausedByRemote:
        case LinphoneCallConnected:{
            NSLog(@"lll=================LinphoneCallConnected");
           
            break;
        }
        case LinphoneCallStreamsRunning:{
            NSLog(@"lll=================LinphoneCallStreamsRunning");
            break;
        }
        case LinphoneCallUpdatedByRemote:{
            NSLog(@"lll=================LinphoneCallUpdatedByRemote");
            break;
        }
        case LinphoneCallError:
        case LinphoneCallEnd:{
            NSLog(@"lll=================LinphoneCallEnd");
            
//            [self exitPhoneView];
            break;
        }
        default:
            break;
    }
    
}
//接听
- (IBAction)onAnswer:(id)sender {
    //add start 201809
    linphone_core_enable_mic([LinphoneManager getLc], true);
    call = linphone_core_get_current_call([LinphoneManager getLc]);
    [[LinphoneManager instance] setSpeakerEnabled:TRUE];
    [[LinphoneManager instance] acceptCall:call];

    //add end
}
//接听对方来电
-(void)acceptCallFromPeer:(LinphoneCall*) call{
    //add start 201809
//    [[LinphoneManager instance] setSpeakerEnabled:TRUE];
    //add end
    
//    if (linphone_call_camera_enabled(call)) {
//        linphone_call_enable_camera(call,false);
//    }
//
//    if(linphone_core_mic_enabled([LinphoneManager getLc])){
//        linphone_core_enable_mic([LinphoneManager getLc], FALSE);
//    }
//    [[LinphoneManager instance] acceptCall:call];
    
}
//开启视频
- (void)setVideoEnable:(BOOL)isOn {
    LinphoneCore* lc = [LinphoneManager getLc];
    if (!linphone_core_video_enabled(lc))
        return;
    
    LinphoneCall* call = linphone_core_get_current_call([LinphoneManager getLc]);
    if (call) {
        LinphoneCallParams* call_params =  linphone_call_params_copy(linphone_call_get_current_params(call));
        linphone_call_params_enable_video(call_params, isOn);
//        linphone_core_update_call(lc, call, call_params);
        linphone_call_params_destroy(call_params);
    }
}
//监视
- (IBAction)onCall:(id)sender {
    NSString *calleeNumber = _calleeNumber.text;
    NSString *yourAdd = [NSString stringWithFormat:@"sip:%@@%@",calleeNumber,OUR_DOMAIN];
    linphone_core_enable_mic([LinphoneManager getLc], false);
    [[LinphoneManager instance] call:yourAdd displayName:calleeNumber transfer:NO];
}

//挂断
- (IBAction)onRingup:(id)sender {
    linphone_core_terminate_call([LinphoneManager getLc],
                                 linphone_core_get_current_call([LinphoneManager getLc]));
}
//开门
- (IBAction)onOpenDoor:(id)sender {
//    [self sendDtmf:'#'];
    NSString *calleeSipAccount = @"3000";
    NSString *domain = @"120.76.225.49";
    [[LinphoneManager instance] unlock:calleeSipAccount domain:domain];
}

-(void)sendDtmf:(char) digit{
    if (linphone_core_in_call([LinphoneManager getLc])) {
        linphone_core_send_dtmf([LinphoneManager getLc], digit);
        linphone_core_play_dtmf([LinphoneManager getLc], digit, 100);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            linphone_core_stop_dtmf([LinphoneManager getLc]);
        });
    }
}
//注册
- (IBAction)onRegister:(id)sender {
    NSString *username = _username.text;
//    NSString *password = _password.text;
    NSString *password = @"legrand";
    NSString *domain = @"120.76.225.49";
    [pb registerSipAccount:username password:password domain:domain];
}
//Tls注册
- (IBAction)onRegisterWithTls:(id)sender {
}
//注销
- (IBAction)onUnregister:(id)sender {
    [[LinphoneManager instance] unregisterSipaccount];
}

//抓拍
- (void)takeSnapshot{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}

@end
