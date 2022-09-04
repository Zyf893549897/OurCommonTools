//
//  ZZWPopAlert2ViewController.h
//  botella
//
//  Created by coding on 2022/8/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZZWPopAlert2ViewController;
@protocol ZZWPopAlert2ViewControllerDelegate <NSObject>
@optional
- (void)ZZWPopAlert2ViewController:(ZZWPopAlert2ViewController *)vc tapCancelButton:(UIButton *)btn;
- (void)ZZWPopAlert2ViewController:(ZZWPopAlert2ViewController *)vc tapSureButton:(UIButton *)btn;
@end

@interface ZZWPopAlert2ViewController : UIViewController
@property (nonatomic, weak) id<ZZWPopAlert2ViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
