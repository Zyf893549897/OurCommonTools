//
//  ZZWNetworkManager.h
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//
/**
 借助第三方库AFNetworking、SDWebImage来做基本的网络处理类，包含发送post、get等请求，上次图片、视频文件等等
 APP只需要传入必要的参数就可以得到想要的结果
 只针对 网络超时、无网络等几种错误情况做了判断
 不参与请求成功的数据处理
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString * const NetworkErrorReason;
typedef NS_ENUM(NSInteger,NetworkResult) {
    
    NetworkResultSuccess,       //获取成功
    NetworkResultFailure,       //获取失敗
    NetworkResultServerError,   //服务器问题
    NetworkResultTimeout,       //超時
    NetworkResultNotNetwork     //沒有网络
};

@interface NetworkModel : NSObject

/**
 服务器IP地址字符串
 */
@property (nonatomic,strong) NSString *ipString;
/**
 接口定义的编号，表示动作
 */
@property (nonatomic,strong) NSString *cmd;

/**
 参数字典，绝大部分的请求都是参数字典
 */
@property (nonatomic,strong) NSDictionary *paramterDic;

/**
 参数数组，少部分的请求参数是数组
 */
@property (nonatomic,strong) NSArray *paramterArr;
@end

@interface ZZWNetworkManager : NSObject
@property(nonatomic,strong)NSString *requestHeaderToken;
+(instancetype)shareManager;
-(void)setHead:(NSString *)head withValue:(NSString *)value;
- (void)getWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion;
- (void)postWithJsonParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion;
- (void)PostWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion;

-(void)uploadData:(NSData*)data mineType:(NSString *)mineType model:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion;

-(void)uploadDatas:(NSArray *)datas mineTypes:(NSArray *)types names:(NSArray *)names model:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion;

-(void)downloadWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion;

- (void)setJsonRequestSerializer;

- (void)disableJsonRequestSerializer;
@end

NS_ASSUME_NONNULL_END
