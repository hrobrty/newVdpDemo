//
//  PhoneViewController.h
//  LinPhoneDemo
//
//  Created by louis on 18/08/08.
//  Copyright (c) 2018年 louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinphoneManager.h"
#import "PhoneBridge.h" //add 

@interface PhoneViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *calleeNumber;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
