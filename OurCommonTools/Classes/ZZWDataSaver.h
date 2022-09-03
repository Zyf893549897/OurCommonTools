//
//  ZZWDataSaver.h
//  NEPWallet
//
//  Created by 周泽文 on 2018/9/20.
//  Copyright © 2018年 zhouzewen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChatMessageModel;
@class ChatMemberModel;

@interface ZZWDataSaver : NSObject
+(instancetype)shareManager;
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *mnemonicWord;
@property(nonatomic,strong)NSString *phoneNumber;
@property(nonatomic,strong)NSString *isSigned;
@property(nonatomic,strong)NSString *gesture;
@property(nonatomic,assign)BOOL hadGesture;
@property(nonatomic,assign)BOOL hadExist;
@property(nonatomic,strong)NSString *headUrl;
@property(nonatomic,strong)NSString *headPath;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *smsToken;//临时token
@property(nonatomic,strong)NSString *token;//注册成功返回的token
@property(nonatomic,strong)NSString *step;//注册的step值
@property(nonatomic,strong)NSString *iM_sig;//腾讯返回的Sig
@property(nonatomic,strong)NSString *inviteCode;//邀请码
@property(nonatomic,assign)NSInteger userId;//用户的id
@property(nonatomic,strong)NSString *voiceRoomId;//房间号
@property(nonatomic,assign)BOOL agreeWeituo;//同意了委托协议
@property(nonatomic,assign)NSInteger cardAuth;//1已认证，2.审核中，3.未通过，4.未认证
@property(nonatomic,assign)NSInteger educationAuth;//1已认证，2.审核中，3.未通过，4.未认证
@property(nonatomic,assign)NSInteger followedRoomNum;//    关注房间的数量
@property(nonatomic,assign)BOOL isNotFirstOpenSpoofGift;//  首次打开恶搞礼物
@property(nonatomic,assign)BOOL hadEnterVoiceRoom;//  已经进入过语音房

@property(nonatomic,assign)BOOL isVIP;
@property(nonatomic,assign)NSInteger cancelStatus;//1-开始注销，0-恢复，2-完成注销
@property(nonatomic,assign)BOOL isNoticeVersionUpdate;//已经告知版本更新
@property(nonatomic,assign)NSInteger isNewVersion;//这是新版本
@property(nonatomic,assign)NSInteger investLevel;//购买节点类型
@property(nonatomic,assign)BOOL isSetPayPassword;//是否设置了支付密码
@property(nonatomic,assign)NSInteger authStatus;//实名认证的状态
@property(nonatomic,strong)NSString *walletAddress;//钱包地址

//和其他数据存储不在同一个字典中，这样登出的时候清空其他数据，是否安装过app 还可以知道
@property(nonatomic,assign)BOOL isInstalledApp;//是否安装过该app
/// 当前用户有多少瓶盖
@property(nonatomic,assign) NSInteger bottleCap;
// 是否在语音房间
@property (nonatomic, assign) BOOL isInVoiceRoom;

@property (nonatomic, strong) UINavigationController *currNav;

-(void)clearData;
-(void)createChatRoomWithName:(NSString *)name;
-(BOOL)addChatMessage:(ChatMessageModel *)model toTable:(NSString *)name;
-(NSArray *)queryMessageWithLength:(NSInteger)length index:(NSInteger)index fromTable:(NSString *)name;

-(void)createChatMemberDBWithName:(NSString *)name;
-(BOOL)addChatMemberModel:(ChatMemberModel *)model toTable:(NSString *)name;
-(NSArray *)queryAllMemberFromTable:(NSString *)table;
-(ChatMemberModel *)queryChatMemberWithUID:(NSString *)uid fromTable:(NSString *)name;
-(void)deleteTableWithName:(NSString *)name;

@end
