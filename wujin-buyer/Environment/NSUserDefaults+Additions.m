//
//  NSUserDefaults+Additions.m
//  HKSportMap
//
//  Created by AsOne on 13-2-1.
//  Copyright (c) 2013年 AsOne. All rights reserved.
//

#import "NSUserDefaults+Additions.h"

NSString *const DefaultsKeyCurrentLocation = @"currentLocation";
NSString *const DefaultsKeyCurrentCity = @"currentCity";
NSString *const DefaultsKeyCurrentCityName = @"currentCityName";
NSString *const DefaultsKeyCurrentUserEmail = @"currentUserEmail";
NSString *const DefaultsKeyCurrentUserPsw = @"currentUserPsw";
NSString *const DefaultsKeyCurrentMemberID = @"currentMemberID";
NSString *const DefaultsKeyCurrentVisitorID = @"currentVisitorID";
NSString *const DefaultsKeyCurrentMemberNick = @"currentMemberNick";
NSString *const DefaultsKeyCurrentMessageCount = @"currentMessageCount";
NSString *const DefaultsKeyCurrentChatRecordCount = @"currentChatRecordCount";
NSString *const DefaultsKeyQID = @"DefaultsKeyQID";
NSString *const DefaultsKeyCurrentAvatar = @"currentAvatar";
NSString *const DefaultskeyCurrentUserToken = @"currentUserToken";
NSString *const DefaultskeyCurrentDeviceID = @"currentDeviceID";

NSString *const DefaultsKeyISFirstLogin = @"isFirstLogin";
NSString *const DefatltsKeyLoginType = @"LoginType"; // qq  sina universal
NSString *const DefaultskeyUserType = @"userType";

NSString *const DefaultsKeyLoginName = @"DefaultsKeyLoginName";

NSString * const DefaultsKeyUserInfo = @"DefaultsKeyUserInfo";

@implementation NSUserDefaults (Additions)

- (NSNumber *)userType {
    
      return  [self valueForKey:DefaultskeyUserType];
}

- (void)setUserType:(NSNumber *)userType {
    
    [self setObject:userType forKey:DefaultskeyUserType];
    [self synchronize];
}


/****************************应用信息相关************************************/
- (void)setIsFirstIn:(NSString *)firstIn {
    
    [self setObject:firstIn forKey:DefaultsKeyISFirstLogin];
    [self synchronize];
}

- (BOOL)isFirstIn {
    
    NSString * isFirstIn = [self valueForKey:DefaultsKeyISFirstLogin];
    
    if (isFirstIn) {
        return YES;
    }
    return NO;
}

- (void)setLoginType:(NSString *)loginType {
    
    [self setObject:loginType forKey:DefatltsKeyLoginType];
    [self synchronize];
}

- (NSString *)loginType {
    
   return  [self valueForKey:DefatltsKeyLoginType];

}

- (void)clearLoginType {
    
    [self removeObjectForKey:DefatltsKeyLoginType];
    [self synchronize];
    
}

/*****************************当前位置相关**********************************/

-(void)setCurrentlocation:(NSDictionary *)currentLocation{
    [self setObject:currentLocation forKey:DefaultsKeyCurrentLocation];
    [self synchronize];
}

-(NSString*)currentlocation{
    return [self valueForKey:DefaultsKeyCurrentLocation];
}

- (void)clearCurrentLocation{
    
    [self removeObjectForKey:DefaultsKeyCurrentLocation];
    [self synchronize];
}

-(void)setCurrentCity:(NSString *)currentCity{
    [self setObject:currentCity forKey:DefaultsKeyCurrentCity];
    [self synchronize];
}

-(NSString*)currentCity{
    return [self stringForKey:DefaultsKeyCurrentCity];
}

- (void)setCurrentCityName:(NSString *)currentCityName{
    
    [self setObject:currentCityName forKey:DefaultsKeyCurrentCityName];
    [self synchronize];
}

- (NSString*)currentCityName{
    
    return [self valueForKey:DefaultsKeyCurrentCityName];
}

/*****************************当前用户相关**********************************/

-(void)setCurrentDeviceID:(NSString *)deviceID {
    [self setObject:deviceID forKey:DefaultskeyCurrentDeviceID];
    [self synchronize];
}
-(NSString*)currentDeviceID {
    return [self stringForKey:DefaultskeyCurrentDeviceID];
}


-(void)setCurrentUserToken:(NSString *)currentUserToken {
    [self setObject:currentUserToken forKey:DefaultskeyCurrentUserToken];
    [self synchronize];
}
-(NSString*)currentUserToken {
    return [self stringForKey:DefaultskeyCurrentUserToken];
}

- (void)clearCurentUserToken {
    [self removeObjectForKey:DefaultskeyCurrentUserToken];
    [self synchronize];
}

-(void)setCurrentMemberAvatar:(NSString *)currentMemberAvatar{
    [self setObject:currentMemberAvatar forKey:DefaultsKeyCurrentAvatar];
    [self synchronize];
}
-(NSString*)currentMemberAvatar{
    return [self stringForKey:DefaultsKeyCurrentAvatar];
}

- (void)clearCurrentAvatar {
    [self removeObjectForKey:DefaultsKeyCurrentAvatar];
    [self synchronize];
}

-(void)setCurrentUserEmail:(NSString *)currentUserEmail{
    [self setObject:currentUserEmail forKey:DefaultsKeyCurrentUserEmail];
    [self synchronize];
}
-(NSString*)currentUserEmail{
    return [self stringForKey:DefaultsKeyCurrentUserEmail];
}

-(void)setCurrentUserPsw:(NSString *)currentUserPsw{
    [self setObject:currentUserPsw forKey:DefaultsKeyCurrentUserPsw];
    [self synchronize];
}
-(NSString*)currentUserPsw{
    return [self stringForKey:DefaultsKeyCurrentUserPsw];
}

- (NSString*)currentMemberID{

    return [self valueForKey:DefaultsKeyCurrentMemberID];
}

- (void)setCurrentMemberID:(NSString *)currentMemberID{
    
    [self setObject:currentMemberID forKey:DefaultsKeyCurrentMemberID];
    [self synchronize];
}

- (void)clearCurrentMemberID{
    
    [self removeObjectForKey:DefaultsKeyCurrentMemberID];
    [self synchronize];
}
//visitorID
- (NSString*)visitorID{
    return [self valueForKey:DefaultsKeyCurrentVisitorID];
}
- (void)setVisitorID:(NSString *)visitorID{
    [self setObject:visitorID forKey:DefaultsKeyCurrentVisitorID];
    [self synchronize];
}
- (void)clearVisitorID{
    [self removeObjectForKey:DefaultsKeyCurrentVisitorID];
    [self synchronize];
}

- (NSNumber*)currentMemberNick{
    
    return [self valueForKey:DefaultsKeyCurrentMemberNick];
}

- (void)setCurrentMemberNick:(NSString *)currentMemberNick{
    
    [self setObject:currentMemberNick forKey:DefaultsKeyCurrentMemberNick];
    [self synchronize];
}

///
- (NSString*)currentQid{
    
    return [self valueForKey:DefaultsKeyQID];
}

- (void)setCurrentQid:(NSString *)currentMemberNick{
    
    [self setObject:currentMemberNick forKey:DefaultsKeyQID];
    [self synchronize];
}

- (void)clearCurrentMemberNick{
    
    [self removeObjectForKey:DefaultsKeyCurrentMemberNick];
    [self synchronize];
}


- (void)setCurrentMessageCount:(NSInteger)currentMessageCount{
    
    [self setInteger:currentMessageCount forKey:DefaultsKeyCurrentMessageCount];
    [self synchronize];
}

- (NSInteger)currentMessageCount{
    
    return [self integerForKey:DefaultsKeyCurrentMessageCount];
}

- (void)clearCurrentMessageCount{
    
    [self removeObjectForKey:DefaultsKeyCurrentMessageCount];
    [self synchronize];
}

- (void)clearCurentChatCount{
    
    [self removeObjectForKey:DefaultsKeyCurrentChatRecordCount];
    [self synchronize];
}

- (NSInteger)currentChatRecordCount{
   
    return [self integerForKey:DefaultsKeyCurrentChatRecordCount];
    
}

-(void) setCurrentChatRecordCount:(NSInteger)currentChatRecordCount {
    
    [self setInteger:currentChatRecordCount forKey:DefaultsKeyCurrentChatRecordCount];
     [self synchronize];
    
}
//////////////////

- (NSString *)loginName {

    return [self objectForKey:DefaultsKeyLoginName];
}

- (void) setLoginName:(NSString *)loginName {
    
    [self setValue:loginName forKey:DefaultsKeyLoginName];
}
////////

- (NSDictionary *)userInfo {
    
    return [self valueForKey:@"DefaultsKeyUserInfo"];
    
}

- (void)setUserInfo:(NSDictionary *)userInfo {
    
    [self setValue:userInfo forKey:@"DefaultsKeyUserInfo"];
    
    [self synchronize];
}

/*
 */

@end

