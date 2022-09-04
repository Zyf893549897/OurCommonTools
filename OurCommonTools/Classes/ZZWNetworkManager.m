//
//  ZZWNetworkManager.m
//  NEPFoundation
//
//  Created by 周泽文 on 2018/10/11.
//  Copyright © 2018年 周泽文. All rights reserved.
//

#import "ZZWNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "ZZWTool.h"
#import "ZZWDataSaver.h"
#import "NSArray+Log.h"
#import "NSDictionary+Log.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "UIViewController+Add.h"

static ZZWNetworkManager *_manager = nil;
NSString * const NetworkErrorReason = @"reason";
@interface ZZWNetworkManager ()

@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (nonatomic,strong) AFNetworkReachabilityManager *networkManager;
@end
@implementation NetworkModel

@end
@implementation ZZWNetworkManager
+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [ZZWNetworkManager new];
    });
    return _manager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
//        NSDictionary* form = @{@"name":@"lisi",@"age":@(30), @"isMarryed":@(YES)};
//
//        NSMutableURLRequest* formRequest = [[AFHTTPRequestSerializerserializer]requestWithMethod:@"POST"URLString:routerAddressparameters:formerror:nil];
//
//        [formRequestsetValue:@"application/x-www-form-urlencoded; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
//
//        AFHTTPSessionManager*manager = [AFHTTPSessionManagermanager];
//
//        AFJSONResponseSerializer* responseSerializer = [AFJSONResponseSerializerserializer];
//
//        [responseSerializersetAcceptableContentTypes:[NSSetsetWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil]];
//
//        manager.responseSerializer= responseSerializer;
//
//        NSURLSessionDataTask*dataTask = [managerdataTaskWithRequest:formRequestuploadProgress:nildownloadProgress:nilcompletionHandler:^(NSURLResponse*_Nonnullresponse,id_NullableresponseObject,NSError*_Nullableerror) {
//
//            if(error) {
//
//                NSLog(@"Error: %@", error);
//
//                return;
//
//            }
//
//            NSLog(@"%@ %@", response, responseObject);
//
//        }];
//
//        [dataTaskresume];
        
        //基礎配置
        self.manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;//解决后台放回NULL问题
        self.manager.responseSerializer = response;
        self.manager.requestSerializer.HTTPShouldHandleCookies = NO;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/x-www-form-urlencoded",@"text/json", @"text/javascript", @"text/html", @"text/plain", @"image/jpeg",nil];
        self.manager.requestSerializer.timeoutInterval = 20;
    }
    return self;
}

- (void)setAppInfo {
    [self.manager.requestSerializer setValue:[ZZWTool getJsonStrWithDictionary:[ZZWTool getDeviceInfo]] forHTTPHeaderField:@"userEquipInfoVo"];
}

-(void)setJsonRequestSerializer {
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
}

- (void)disableJsonRequestSerializer {
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}

-(void)setRequestHeaderToken:(NSString *)requestHeaderToken{
//    if (_requestHeaderToken == nil) {
        _requestHeaderToken = requestHeaderToken;
        [self.manager.requestSerializer setValue:requestHeaderToken forHTTPHeaderField:@"token"];
    [self setAppInfo];
//    }
}
-(void)setHead:(NSString *)head withValue:(NSString *)value{
    [self.manager.requestSerializer setValue:value forHTTPHeaderField:head];
}
- (void)getWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion{
    
    NSString *urlStr = [model.ipString stringByAppendingFormat:@"%@",model.cmd];//拼接url字符串
    NSDate *startRequestDate = [NSDate date];
    [self showNetworkActivityVisible:YES];
    
    [self.manager GET:urlStr parameters:model.paramterDic headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
            NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",[ZZWTool getChineseTimeWithDate:startRequestDate],task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
        [self showNetworkActivityVisible:NO];
        if (!completion) {
            return;
        }
        NSLog(@"请求成功 ：responseObject==%@",responseObject);
        completion(NetworkResultSuccess,responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self showNetworkActivityVisible:NO];
        NSLog(@"请求失败 ：error==%@",error);
        NSString *errorText = error.userInfo[@"NSLocalizedDescription"];
        
        if ([errorText isEqualToString:@"The request timed out."])
        {
            completion(NetworkResultTimeout,@{NetworkErrorReason:@"请求超时"});
        }
        else if ([errorText isEqualToString:@"Could not connect to the server."])
        {
            completion(NetworkResultServerError,@{NetworkErrorReason:@"无法连接到服务器"});
        }
        else if ([errorText isEqualToString:@"The Internet connection appears to be offline."])
        {
            completion(NetworkResultNotNetwork,@{NetworkErrorReason:@"没有网络"});
        }else{
            completion(NetworkResultFailure,error);
        }
    }];
    
}
- (void)postWithJsonParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion{
    NSString *urlStr = [model.ipString stringByAppendingString:model.cmd];//拼接url字符串
       [self showNetworkActivityVisible:YES];
       NSDate *startRequestDate = [NSDate date];
       NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:model.paramterArr error:nil];
       [request setValue:_requestHeaderToken forHTTPHeaderField:@"token"];

       [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *task = [self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
        NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",
              [ZZWTool getChineseTimeWithDate:startRequestDate],
              response.URL,
              request.HTTPMethod,
              request.allHTTPHeaderFields,[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding],
              @(time));

        if (!error) {
            completion(NetworkResultSuccess,responseObject);
        } else {
            NSLog(@"请求失败error=%@", error);
        }
    }];
    [task resume];
////       self.manager datata
//       NSURLSessionDataTask *task = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//           NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
//           NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",
//                 [ZZWTool getChineseTimeWithDate:startRequestDate],
//                 response.URL,
//                 request.HTTPMethod,
//                 request.allHTTPHeaderFields,[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding],
//                 @(time));
//
//           if (!error) {
//               completion(NetworkResultSuccess,responseObject);
//           } else {
//               NSLog(@"请求失败error=%@", error);
//           }
//       }];
//
//       [task resume];
    
//    [self.manager POST:urlStr parameters:model.paramterDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
//        NSDictionary *dic =task.originalRequest.allHTTPHeaderFields;
//        NSLog(@"%@",dic);
//            NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",[ZZWTool getChineseTimeWithDate:startRequestDate],task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
//
//
//
//        [self showNetworkActivityVisible:NO];
//        if (!completion) {
//            return;
//        }
//        NSLog(@"请求成功 ：responseObject==%@",responseObject);
//        completion(NetworkResultSuccess,responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
//        NSDictionary *dic =task.originalRequest.allHTTPHeaderFields;
//        NSLog(@"%@",dic);
//            NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",[ZZWTool getChineseTimeWithDate:startRequestDate],task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
//        [self showNetworkActivityVisible:NO];
//        NSLog(@"请求失败 ：error==%@",error);
//        NSString *errorText = error.userInfo[@"NSLocalizedDescription"];
//
//        if ([errorText isEqualToString:@"The request timed out."])
//        {
//            completion(NetworkResultTimeout,@{NetworkErrorReason:@"请求超时"});
//        }
//        else if ([errorText isEqualToString:@"Could not connect to the server."])
//        {
//            completion(NetworkResultServerError,@{NetworkErrorReason:@"无法连接到服务器"});
//        }
//        else if ([errorText isEqualToString:@"The Internet connection appears to be offline."])
//        {
//            completion(NetworkResultNotNetwork,@{NetworkErrorReason:@"没有网络"});
//        }else{
//            completion(NetworkResultFailure,error);
//        }
//
//    }];
}

- (void)PostWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion{

    NSString *urlStr = [model.ipString stringByAppendingString:model.cmd];//拼接url字符串
    [self showNetworkActivityVisible:YES];
    NSDate *startRequestDate = [NSDate date];
 
    [self.manager POST:urlStr parameters:model.paramterDic headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
        NSDictionary *dic =task.originalRequest.allHTTPHeaderFields;
        NSLog(@"%@",dic);
            NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",[ZZWTool getChineseTimeWithDate:startRequestDate],task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
        [self showNetworkActivityVisible:NO];
        if (!completion) {
            return;
        }
        NSLog(@"请求成功 ：responseObject==%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 401) {
            if (![[UIViewController getCurrentViewController] isKindOfClass:[LoginViewController class]]) {
                [(AppDelegate*)[UIApplication sharedApplication].delegate switchLoginRootVC];
                [WLToastManager showTitle:responseObject[@"msg"]];
            }
            completion(NetworkResultFailure,responseObject);
        } else {
            completion(NetworkResultSuccess,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
        NSDictionary *dic =task.originalRequest.allHTTPHeaderFields;
        NSLog(@"%@",dic);
            NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",[ZZWTool getChineseTimeWithDate:startRequestDate],task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
        [self showNetworkActivityVisible:NO];
        NSLog(@"请求失败 ：error==%@",error);
        NSString *errorText = error.userInfo[@"NSLocalizedDescription"];
        
        if ([errorText isEqualToString:@"The request timed out."])
        {
            completion(NetworkResultTimeout,@{NetworkErrorReason:@"请求超时"});
        }
        else if ([errorText isEqualToString:@"Could not connect to the server."])
        {
            completion(NetworkResultServerError,@{NetworkErrorReason:@"无法连接到服务器"});
        }
        else if ([errorText isEqualToString:@"The Internet connection appears to be offline."])
        {
            completion(NetworkResultNotNetwork,@{NetworkErrorReason:@"没有网络"});
        }else{
            completion(NetworkResultFailure,error.userInfo);
        }

    }];
}

-(void)downloadWithParametersModel:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion{
    [self showNetworkActivityVisible:YES];
    
    NSURL *url = [NSURL URLWithString:model.paramterDic[@"downloadUrl"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSString *downloadPath = model.paramterDic[@"downloadPath"];
    
    NSURLSessionDownloadTask *downloadTask = [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"downloadTask progress %lld", downloadProgress.completedUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *downloadUrl = [NSURL fileURLWithPath:downloadPath];
        return [downloadUrl URLByAppendingPathComponent:url.lastPathComponent];
//                [NSString stringWithFormat:@"%@/%@",downloadPath,[response suggestedFilename]]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"success downloaded to: %@", filePath);
        completion(NetworkResultSuccess,filePath.filePathURL);
    }];
    [downloadTask resume];
}

-(void)uploadDatas:(NSArray *)datas mineTypes:(NSArray *)types names:(NSArray *)names model:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion{
    NSString *urlStr = [model.ipString stringByAppendingString:model.cmd];//拼接url字符串
    [self showNetworkActivityVisible:YES];
    NSDate *startRequestDate = [NSDate date];
    [self.manager POST:urlStr parameters:model.paramterDic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < datas.count; i++) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
            [formData appendPartWithFileData:datas[i] name:names[i] fileName:fileName mimeType:types[i]];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
        NSDictionary *dic =task.originalRequest.allHTTPHeaderFields;
        NSLog(@"%@",dic);
            NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",[ZZWTool getChineseTimeWithDate:startRequestDate],task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
        
        [self showNetworkActivityVisible:NO];
        completion(NetworkResultSuccess,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:startRequestDate];
        NSDictionary *dic =task.originalRequest.allHTTPHeaderFields;
        NSLog(@"%@",dic);
            NSLog(@"\n开始时间:%@\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求体信息:%@\n请求响应时间:%@\n",[ZZWTool getChineseTimeWithDate:startRequestDate],task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
        
        [self showNetworkActivityVisible:NO];
        NSLog(@"%@",error);
        NSString *errorText = error.userInfo[@"NSLocalizedDescription"];
        
        if ([errorText isEqualToString:@"The request timed out."])
        {
            completion(NetworkResultTimeout,@{NetworkErrorReason:@"请求超时"});
        }
        else if ([errorText isEqualToString:@"Could not connect to the server."])
        {
            completion(NetworkResultServerError,@{NetworkErrorReason:@"无法连接到服务器"});
        }
        else if ([errorText isEqualToString:@"The Internet connection appears to be offline."])
        {
            completion(NetworkResultNotNetwork,@{NetworkErrorReason:@"没有网络"});
        }else{
            completion(NetworkResultFailure,error);
        }
    }];
}
-(void)uploadData:(NSData*)data mineType:(NSString *)mineType model:(NetworkModel *)model completion:(void (^)(NetworkResult result, id  _Nullable responseObject))completion{
    NSString *urlStr = [model.ipString stringByAppendingString:model.cmd];//拼接url字符串
    [self showNetworkActivityVisible:YES];
    [self.manager POST:urlStr parameters:model.paramterDic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 根据时间生成图片的名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:data name:@"uploadFile" fileName:fileName mimeType:mineType];
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self showNetworkActivityVisible:NO];
         completion(NetworkResultSuccess,responseObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self showNetworkActivityVisible:NO];
         NSLog(@"%@",error);
         NSString *errorText = error.userInfo[@"NSLocalizedDescription"];
         
         if ([errorText isEqualToString:@"The request timed out."])
         {
             completion(NetworkResultTimeout,@{NetworkErrorReason:@"请求超时"});
         }
         else if ([errorText isEqualToString:@"Could not connect to the server."])
         {
             completion(NetworkResultServerError,@{NetworkErrorReason:@"无法连接到服务器"});
         }
         else if ([errorText isEqualToString:@"The Internet connection appears to be offline."])
         {
             completion(NetworkResultNotNetwork,@{NetworkErrorReason:@"没有网络"});
         }else{
             completion(NetworkResultFailure,error);
         }
     }];
}

- (void)showNetworkActivityVisible:(BOOL)visible {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    });
}

-(void)OtherPostMethod{
    
    //    //1.创建会话对象
    //    NSURLSession *session = [NSURLSession sharedSession];
    //
    //    //2.根据会话对象创建task
    //    NSURL *url = [NSURL URLWithString:[model.ipString stringByAppendingFormat:@"/%@",model.cmd]];
    //
    //    //3.创建可变的请求对象
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //
    //    //4.修改请求方法为POST
    //    request.HTTPMethod = @"POST";
    //    //5.设置请求体
    //    request.HTTPBody = [[NSString stringWithFormat:@"username=%@&password1=%@&password2=%@&email=%@",model.paramterDic[@"username"],model.paramterDic[@"password1"],model.paramterDic[@"password2"],@""] dataUsingEncoding:NSUTF8StringEncoding];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    //6.根据会话对象创建一个Task(发送请求）
    //    /*
    //     第一个参数：请求对象
    //     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
    //     data：响应体信息（期望的数据）
    //     response：响应头信息，主要是对服务器端的描述
    //     error：错误信息，如果请求失败，则error有值
    //     */
    //    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    //
    //        //8.解析数据
    //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //        NSDictionary *dict2 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //        NSDictionary *dict3 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //        NSDictionary *dict4 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //        NSDictionary *dict5 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //        NSLog(@"%@",dict);
    //
    //    }];
    //
    //    //7.执行任务
    //    [dataTask resume];
    
    
    
    //    NSString *urlStr = [model.ipString stringByAppendingFormat:@"/%@/",model.cmd];//拼接url字符串
    //
    //    [self showNetworkActivityVisible:YES];
    //    [self.manager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:model.paramterDic error:nil];
    //    [self.manager POST:urlStr parameters:model.paramterDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //
    //        [self showNetworkActivityVisible:NO];
    //        if (!completion) {
    //            return;
    //        }
    //        completion(NetworkResultSuccess,responseObject);
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        [self showNetworkActivityVisible:NO];
    //        NSLog(@"%@",error);
    //        if (completion) {
    //            completion(NetworkResultServerError,nil);
    //        }
    //    }];
    
    
    
    //    NSString *jsonStr = [ZZWTool getJsonStrWithDictionary:model.paramterDic];
    ////    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    //
    //    NSData *postData = [jsonStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[model.ipString stringByAppendingFormat:@"/%@/",model.cmd] parameters:nil error:nil];
    //    request.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //    [request setValue:[ZZWDataSaver shareManager].key forHTTPHeaderField:@"X-CSRFToken"];
    //    [request setHTTPBody:postData];
    //
    //    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    //        if (!error) {
    ////            NSDictionary *fields = (NSHTTPURLResponse*)response.allHeaderFields;
    ////            NSLog(@"fields = %@",[fields description]);
    ////            NSURL *url = [NSURL URLWithString:@"http://dev.skyfox.org/cookie.php"];
    ////            NSLog(@"\n======================================\n");
    ////            //获取cookie方法1
    ////            NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:url];
    ////            for (NSHTTPCookie *cookie in cookies) {
    ////                NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
    ////            }
    ////            NSLog(@"\n======================================\n");
    //
    //
    //            completion(NetworkResultSuccess,responseObject);
    //            NSLog(@"responseObject: %@", responseObject);
    //        } else {
    ////            NSError *underError = error.userInfo[@"NSErrorFailingURLKey"];
    //
    //            NSData *responseData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    //
    //            NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
    //
    //            NSLog(@"%@",result);
    //
    //            NSLog(@"error: %@, %@, %@", error, response, responseObject);
    //            completion(NetworkResultFailure,responseObject);
    //        }
    //    }] resume];
}
@end
