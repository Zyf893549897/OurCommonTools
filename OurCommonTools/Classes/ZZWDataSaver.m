//
//  ZZWDataSaver.m
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/20.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import "ZZWDataSaver.h"
//#import "FMDB.h"
#import "ChatMemberModel.h"
#import "ChatMessageModel.h"
#define OBJECT_KEY @"botella"
NSString *kIsInstalledApp= @"isInstalledApp";
NSString *kPublicKey = @"publicKey";
NSString *kKey = @"key";
NSString *kPassword = @"password";
NSString *kPrivateKey = @"privateKey";
NSString *kmnemonicWord = @"mnemonicWord";
NSString *kPhoneNumber = @"phoneNumber";
NSString *kSigned = @"signed";
NSString *kHadGesture = @"hadGesture";
NSString *kGesture = @"gesture";
NSString *kHadExist = @"hadExist";
NSString *kNickname = @"nickname";
NSString *kInviteCode = @"inviteCode";
NSString *kUserId = @"userId";
NSString *kSmsToken = @"smsToken";
NSString *kToken = @"token";
NSString *kStep = @"step";
NSString *kCancelStatus = @"cancelStatus";
NSString *kVoiceRoomId = @"VoiceRoomId";
NSString *kAgreeWeituo = @"agreeWeituo";
NSString *kIsNotFirstOpenSpoofGift = @"isNotFirstOpenSpoofGift";
NSString *kHadEnterVoiceRoom = @"hadEnterVoiceRoom";

NSString *kHeadUrl = @"headUrl";
NSString *kEmail = @"email";
NSString *kIsVIP = @"isVIP";
NSString *kFollowedRoomNum = @"followedRoomNum";


NSString *kCardAuth = @"cardAuth";
NSString *kEducationAuth = @"educationAuth";

NSString *kIsNewVersion = @"isNewVersion";
NSString *kIsNoticeVersionUpdate = @"isNoticeVersionUpdate";
NSString *kIsSetPayPassword = @"isSetPayPassword";
NSString *kAuthStatus = @"authStatus";
NSString *kWalletAddress = @"walletAddress";
NSString *kInvestLevel = @"walletAddress";
NSString *kHeadPath = @"headPath";
NSString *kIM_sig = @"iM_sig";

static ZZWDataSaver *_saver = nil;

@interface ZZWDataSaver()
//@property(nonatomic,strong)FMDatabase *chatRoomDB;
//@property(nonatomic,strong)FMDatabase *roomMemberDB;
@end

@implementation ZZWDataSaver
+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _saver = [ZZWDataSaver new];
    });
    return _saver;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        
    }
    return self;
}
-(void)setIsInstalledApp:(BOOL)isInstalledApp{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:isInstalledApp forKey:kIsInstalledApp];
    [userDefault synchronize];
    
}
-(BOOL)isInstalledApp{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsInstalledApp];
}

-(void)setWalletAddress:(NSString *)walletAddress{
    [self setObject:walletAddress forKey:kWalletAddress];
}
-(NSString *)walletAddress{
    return [self objectForKey:kWalletAddress];
}
-(void)setInvestLevel:(NSInteger)investLevel{
    [self setObject:[NSNumber numberWithInteger:investLevel] forKey:kInvestLevel];
}
-(NSInteger)investLevel{
    return [[self objectForKey:kInvestLevel] integerValue];
}
-(void)setAuthStatus:(NSInteger)authStatus{
    [self setObject:[NSNumber numberWithInteger:authStatus] forKey:kAuthStatus];
}
-(NSInteger)authStatus{
    return [[self objectForKey:kAuthStatus] integerValue];
}
-(void)setCancelStatus:(NSInteger)cancelStatus{
    [self setObject:[NSNumber numberWithInteger:cancelStatus] forKey:kCancelStatus];
}
-(NSInteger)cancelStatus{
    return [[self objectForKey:kCancelStatus] integerValue];
}
-(void)setIsSetPayPassword:(BOOL)isSetPayPassword{
    [self setObject:[NSNumber numberWithInteger:isSetPayPassword] forKey:kIsSetPayPassword];
}
-(BOOL)isSetPayPassword{
    return [[self objectForKey:kIsSetPayPassword] integerValue];
}

-(void)setIsNoticeVersionUpdate:(BOOL)isNoticeVersionUpdate{
    [self setObject:[NSNumber numberWithInteger:isNoticeVersionUpdate] forKey:kIsNoticeVersionUpdate];
}
-(BOOL)isNoticeVersionUpdate{
    return [[self objectForKey:kIsNoticeVersionUpdate] integerValue];
}
-(void)setIsNewVersion:(NSInteger)isNewVersion{
    [self setObject:[NSNumber numberWithInteger:isNewVersion] forKey:kIsNewVersion];
}

-(NSInteger)isNewVersion{
    return [[self objectForKey:kIsNewVersion] integerValue];
}
-(void)setIM_sig:(NSString *)iM_sig{
    [self setObject:iM_sig forKey:kIM_sig];
}
-(NSString *)iM_sig{
    return [self objectForKey:kIM_sig];
}
-(void)setEmail:(NSString *)email{
    [self setObject:email forKey:kEmail];
}
-(NSString *)email{
    return [self objectForKey:kEmail];
}
-(void)setHeadPath:(NSString *)headPath{
    [self setObject:headPath forKey:kHeadPath];
}
-(NSString *)headPath{
    return [self objectForKey:kHeadPath];
}
-(void)setHeadUrl:(NSString *)headUrl{
    [self setObject:headUrl forKey:kHeadUrl];
}
-(NSString *)headUrl{
    return [self objectForKey:kHeadUrl];
}
-(void)setAgreeWeituo:(BOOL)agreeWeituo{
    [self setObject:[NSNumber numberWithBool:agreeWeituo] forKey:kAgreeWeituo];
}
-(BOOL)agreeWeituo{
    return [[self objectForKey:kAgreeWeituo] boolValue];
}
-(void)setIsNotFirstOpenSpoofGift:(BOOL)isNotFirstOpenSpoofGift{
    [self setObject:[NSNumber numberWithBool:isNotFirstOpenSpoofGift] forKey:kIsNotFirstOpenSpoofGift];
}
-(BOOL)isNotFirstOpenSpoofGift{
    return [[self objectForKey:kIsNotFirstOpenSpoofGift] boolValue];
}
-(void)setHadEnterVoiceRoom:(BOOL)hadEnterVoiceRoom{
    [self setObject:[NSNumber numberWithBool:hadEnterVoiceRoom] forKey:kHadEnterVoiceRoom];
}
-(BOOL)hadEnterVoiceRoom{
    return [[self objectForKey:kHadEnterVoiceRoom] boolValue];
}
-(void)setIsVIP:(BOOL)isVIP{
    [self setObject:[NSNumber numberWithBool:isVIP] forKey:kIsVIP];
}
-(BOOL)isVIP{
    return [[self objectForKey:kIsVIP] boolValue];
}
-(void)setVoiceRoomId:(NSString *)voiceRoomId{
    [self setObject:voiceRoomId forKey:kVoiceRoomId];
}
-(NSString *)voiceRoomId{
    return [self objectForKey:kVoiceRoomId];
}

-(void)setSmsToken:(NSString *)tokenValue{
    [self setObject:tokenValue forKey:kSmsToken];
}
-(NSString *)smsToken{
    return [self objectForKey:kSmsToken];
}
-(void)setStep:(NSString *)step{
    [self setObject:step forKey:kStep];
}
-(NSString *)step{
    return [self objectForKey:kStep];
}
-(void)setToken:(NSString *)tokenValue{
    [self setObject:tokenValue forKey:kToken];
}
-(NSString *)token{
    return [self objectForKey:kToken];
}

-(void)setUserId:(NSInteger)userId{
    [self setObject:[NSNumber numberWithInteger:userId] forKey:kUserId];
}
-(NSInteger)userId{
    return [[self objectForKey:kUserId] integerValue];
}

-(void)setCardAuth:(NSInteger)cardAuth{
    [self setObject:[NSNumber numberWithInteger:cardAuth] forKey:kCardAuth];
}
-(NSInteger)cardAuth{
    return [[self objectForKey:kCardAuth] integerValue];
}

-(void)setEducationAuth:(NSInteger)educationAuth{
    [self setObject:[NSNumber numberWithInteger:educationAuth] forKey:kEducationAuth];
}
-(NSInteger)educationAuth{
    return [[self objectForKey:kEducationAuth] integerValue];
}

-(void)setFollowedRoomNum:(NSInteger)followedRoomNum{
    [self setObject:[NSNumber numberWithInteger:followedRoomNum] forKey:kFollowedRoomNum];
}
-(NSInteger)followedRoomNum{
    return [[self objectForKey:kFollowedRoomNum] integerValue];
}
-(void)setInviteCode:(NSString *)inviteCode{
    [self setObject:inviteCode forKey:kInviteCode];
}
-(NSString *)inviteCode{
    return [self objectForKey:kInviteCode];
}
-(void)setNickname:(NSString *)nickname{
    [self setObject:nickname forKey:kNickname];
}
-(NSString *)nickname{
    return [self objectForKey:kNickname];
}

-(void)setHadExist:(BOOL)hadExist{
    [self setObject:[NSNumber numberWithBool:hadExist] forKey:kHadExist];
}
-(BOOL)hadExist{
    return [[self objectForKey:kHadExist] boolValue];
}

-(void)setHadGesture:(BOOL)hadGesture{
    [self setObject:[NSNumber numberWithBool:hadGesture] forKey:kHadGesture];
}
-(BOOL)hadGesture{
    return [[self objectForKey:kHadGesture] boolValue];
}


-(void)setGesture:(NSString *)gesture{
    [self setObject:gesture forKey:kGesture];
}
-(NSString *)gesture{
    return [self objectForKey:kGesture];
}
-(void)setIsSigned:(NSString *)isSigned{
    [self setObject:isSigned forKey:kSigned];
}
-(NSString *)isSigned{
    return [self objectForKey:kSigned];
}

-(void)setPhoneNumber:(NSString *)phoneNumber{
    [self setObject:phoneNumber forKey:kPhoneNumber];
}
-(NSString *)phoneNumber{
    return [self objectForKey:kPhoneNumber];
}

-(void)setKey:(NSString *)key{
    [self setObject:key forKey:kKey];
}
-(NSString *)key{
   return [self objectForKey:kKey];
}

-(void)setPassword:(NSString *)password{
    [self setObject:password forKey:kPassword];
}
-(NSString *)password{
   return [self objectForKey:kPassword];
}
-(void)setPrivateKey:(NSString *)privateKey{
    [self setObject:privateKey forKey:kPrivateKey];
}
-(NSString *)privateKey{
    return [self objectForKey:kPrivateKey];
}
-(void)setMnemonicWord:(NSString *)mnemonicWord{
    [self setObject:mnemonicWord forKey:kmnemonicWord];
}
-(NSString *)mnemonicWord{
    return [self objectForKey:kmnemonicWord];
}
- (void)setObject:(id)object forKey:(NSString *)key {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [userDefault objectForKey:OBJECT_KEY];
    NSMutableDictionary *saveDict = nil;
    
    if (!dict) {
        saveDict = [NSMutableDictionary new];
    }else {
        saveDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    
    if (!object) {
        [saveDict removeObjectForKey:key];
    }else {
        
        [saveDict setObject:object forKey:key];
    }
    [userDefault setObject:saveDict forKey:OBJECT_KEY];
    [userDefault synchronize];
}

- (id)objectForKey:(NSString *)key {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [userDefault objectForKey:OBJECT_KEY];
    return [dict objectForKey:key];
}

-(void)clearData{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:OBJECT_KEY];
    [userDefault synchronize];
}
//-(void)deleteTableWithName:(NSString *)name{
//    //1.创建database路径
//    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//
//    NSString *chatPath = [docuPath stringByAppendingPathComponent:@"chat"];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if (![fm fileExistsAtPath:chatPath]) {
//        [fm createDirectoryAtPath:chatPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    NSString *dbPath = [chatPath stringByAppendingPathComponent:name];
//    [fm removeItemAtPath:dbPath error:nil];
//
//}
//-(void)createChatMemberDBWithName:(NSString *)name{
//    //1.创建database路径
//    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//
//    NSString *chatPath = [docuPath stringByAppendingPathComponent:@"chat"];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if (![fm fileExistsAtPath:chatPath]) {
//        [fm createDirectoryAtPath:chatPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//
//
//    NSString *dbPath = [chatPath stringByAppendingPathComponent:name];
//    NSLog(@"!!!dbPath = %@",dbPath);
//
//    //2.创建对应路径下数据库
//    _roomMemberDB = [FMDatabase databaseWithPath:dbPath];
//
//
//    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
//    [_roomMemberDB open];
//    if (![_roomMemberDB open]) {
//        NSLog(@"db open fail");
//        return;
//    }
//    //4.数据库中创建表（可创建多张）
//    NSString *sql = @"create table if not exists roomMember ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'uid' TEXT NOT NULL,'headUrl' TEXT NOT NULL,'username' TEXT NOT NULL)";
//    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
//    BOOL result = [_roomMemberDB executeUpdate:sql];
//    if (result) {
//        NSLog(@"create table success");
//
//    }
//    [_roomMemberDB close];
//}
//
//-(BOOL)addChatMemberModel:(ChatMemberModel *)model toTable:(NSString *)name{
//    [_roomMemberDB open];
//
//    // 先查询数据库中是否已经有了，有的话就不用插入了
//
//    NSString * sql = @"select * from roomMember where uid = ?;";
//    __block BOOL isExsit = NO;
//    //0.直接sql语句
//    FMResultSet *result = [_roomMemberDB executeQuery:sql withArgumentsInArray:@[model.uid]];
//    while ([result next]) {
//        NSString *uid = [result stringForColumn:@"uid"];
//        NSString *uid2 = [NSString stringWithFormat:@"%ld",[model.uid integerValue]];
//        if ([uid isEqualToString:uid2]) {
//            isExsit = YES;
//
//            NSLog(@"已经存在 %@",model.username);
//        }
//
//    }
//
//    if (isExsit == NO) {
//        NSString *sql001 = @"insert into roomMember (uid, username, headUrl) values (?,?,?)";
//
//        BOOL result = [_roomMemberDB executeUpdate:sql001 withArgumentsInArray:@[model.uid,model.username,model.headUrl]];
//        [_roomMemberDB close];
//        if (result) {
//            NSLog(@"insert into roomMember success");
//            return YES;
//
//        } else {
//            NSLog(@"insert into roomMember fail");
//            return NO;
//
//        }
//    }else{
//        [_roomMemberDB close];
//        return YES;
//    }
//
//
//}
//-(ChatMemberModel *)queryChatMemberWithUID:(NSString *)uid fromTable:(NSString *)name{
//    [_roomMemberDB open];
//    NSString * sql = @"select * from roomMember where uid = ?;";
//
//    //0.直接sql语句
//    FMResultSet *result = [_roomMemberDB executeQuery:sql withArgumentsInArray:@[uid]];
//    ChatMemberModel *model = [ChatMemberModel new];
//
//    while ([result next]) {
//        model.uid = [result stringForColumn:@"uid"];
//        model.username = [result stringForColumn:@"username"];
//        model.headUrl = [result stringForColumn:@"headUrl"];
//        NSLog(@"从数据库查询到的人员 %@",model.username);
//
//    }
//    [_roomMemberDB close];
//    return model;
//}
//-(NSArray *)queryAllMemberFromTable:(NSString *)table{
//    [_roomMemberDB open];
//    NSString * sql = @"select * from roomMember";
//    //0.直接sql语句
//    FMResultSet *result = [_roomMemberDB executeQuery:sql];
//
//    NSMutableArray *arr = [NSMutableArray array];
//    while ([result next]) {
//        ChatMemberModel *model = [ChatMemberModel new];
//        model.uid = [result stringForColumn:@"uid"];
//        model.username = [result stringForColumn:@"username"];
//        model.headUrl = [result stringForColumn:@"headUrl"];
//        [arr addObject:model];
//    }
//    [_roomMemberDB close];
//    return arr.copy;
//}
//-(void)createChatRoomWithName:(NSString *)name{
//    //1.创建database路径
//    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//
//    NSString *chatPath = [docuPath stringByAppendingPathComponent:@"chat"];
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if (![fm fileExistsAtPath:chatPath]) {
//        [fm createDirectoryAtPath:chatPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//
//
//    NSString *dbPath = [chatPath stringByAppendingPathComponent:name];
//    NSLog(@"!!!dbPath = %@",dbPath);
//
//    //2.创建对应路径下数据库
//    _chatRoomDB = [FMDatabase databaseWithPath:dbPath];
//
//
//    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
//    [_chatRoomDB open];
//    if (![_chatRoomDB open]) {
//        NSLog(@"db open fail");
//        return;
//    }
//    //4.数据库中创建表（可创建多张）
//    NSString *sql = @"create table if not exists chatRecord ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'uid' TEXT NOT NULL, 'nickname' TEXT NOT NULL,'head' TEXT NOT NULL,'content' TEXT NOT NULL,'time' TEXT NOT NULL,'messageType' INTEGER NOT NULL,'chatType' INTEGER NOT NULL,'messageStatus' INTEGER NOT NULL,'isRead' INTEGER NOT NULL,'fromMe' INTEGER NOT NULL)";
//    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
//    BOOL result = [_chatRoomDB executeUpdate:sql];
//    if (result) {
//        NSLog(@"create table success");
//
//    }
//    [_chatRoomDB close];
//}
//
//
//-(BOOL)addChatMessage:(ChatMessageModel *)model toTable:(NSString *)name{
//
//    [_chatRoomDB open];
//    NSString *sql001 = @"insert into chatRecord (uid, nickname, head, content, time, messageType, chatType, messageStatus, isRead, fromMe) values (?,?,?,?,?,?,?,?,?,?)";
//
//    BOOL result = [_chatRoomDB executeUpdate:sql001 withArgumentsInArray:@[model.uid,model.nickname,model.head,model.content,model.time,[NSNumber numberWithInteger:model.messageType],[NSNumber numberWithInteger:model.chatType],[NSNumber numberWithInteger:model.messageType],[NSNumber numberWithInteger:model.isRead],[NSNumber numberWithInteger:model.fromMe]]];
//    [_chatRoomDB close];
//    if (result) {
//        NSLog(@"insert into chatRecord success");
//        return YES;
//
//    } else {
//        NSLog(@"insert into chatRecord fail");
//        return NO;
//
//    }
//}
//
//-(NSArray *)queryMessageWithLength:(NSInteger)length index:(NSInteger)index fromTable:(NSString *)name{
//    [_chatRoomDB open];
//    NSString *sql = nil;
//    if (length == 0) {
//        sql = @"select * from chatRecord where (id >= ?);";
//
//    }else{
//        sql = @"select * from chatRecord where (id >= ?) limit ?;";
//    }
//
//
//    FMResultSet *result = [_chatRoomDB executeQuery:sql,[NSNumber numberWithInteger:index],[NSNumber numberWithInteger:length]];
////    FMResultSet *result = [_db executeQuery:@"select * from 'test1' where (id >= 0) limit 10"];
//
//    NSMutableArray *arr=[NSMutableArray array];
//    while ([result next]) {
//        ChatMessageModel *model = [ChatMessageModel new];
//        model.uid = [result stringForColumn:@"uid"];
//        model.head = [result stringForColumn:@"head"];
//        model.nickname = [result stringForColumn:@"nickname"];
//        model.content = [result stringForColumn:@"content"];
//        model.time = [result stringForColumn:@"time"];
//        model.messageType = [result intForColumn:@"messageType"];
//        model.chatType = [result intForColumn:@"chatType"];
//        model.messageStatus = [result intForColumn:@"messageStatus"];
//        model.isRead = [result intForColumn:@"isRead"];
//        model.fromMe = [result intForColumn:@"fromMe"];
//        [arr addObject:model];
//
//    }
//    [_chatRoomDB close];
//    NSLog(@"查询到聊天记录%ld条",arr.count);
//    return arr.copy;
//}


@end
