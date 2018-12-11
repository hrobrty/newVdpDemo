//
//  PhoneSettings.h
//  CommonProject
//
//  Created by louis on 18/08/08.
//  Copyright (c) 2018年 louis. All rights reserved.
//

#import "IASKSettingsStore.h"
#import "IASKSettingsStore.h"

#import "LinphoneManager.h"

@interface PhoneSettings : IASKAbstractSettingsStore{
@private
    NSDictionary *dict;
    NSDictionary *changedDict;
}

- (void)synchronizeAccount;
- (void)transformLinphoneCoreToKeys;

@end
