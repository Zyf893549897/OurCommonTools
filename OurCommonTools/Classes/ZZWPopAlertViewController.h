//
//  ZZWPopAlertViewController.h
//  botella
//
//  Created by coding on 2022/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZZWPopAlertViewController;
@protocol ZZWPopAlertViewControllerDelegate <NSObject>
@optional
- (void)ZZWPopAlertViewController:(ZZWPopAlertViewController *)vc tapSureButton:(UIButton *)btn;
@end

@interface ZZWPopAlertViewController : UIViewController
@property (nonatomic, weak) id<ZZWPopAlertViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
