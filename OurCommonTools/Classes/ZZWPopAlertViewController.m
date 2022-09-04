//
//  ZZWPopAlertViewController.m
//  botella
//
//  Created by coding on 2022/8/5.
//

#import "ZZWPopAlertViewController.h"

@interface ZZWPopAlertViewController ()
@property (nonatomic, strong) UIView *content;
@end

@implementation ZZWPopAlertViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // 这一步非常重要
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 动画效果
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn animations:^{
                            self.content.alpha = 1;
                        } completion:nil];
}
// 视图和布局
- (void)setviews {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UIView *content = [[UIView alloc] init];
    content.backgroundColor = [UIColor colorWithHex:@"#15213B"];
    content.layer.cornerRadius = 10;
    content.clipsToBounds = YES;
    content.alpha = 0;
    [self.view addSubview:content];
    _content = content;
    
    // 获取语音验证码
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = FontSize14;
    titleL.numberOfLines = 0;
    titleL.text = @"恶搞礼物只能单独赠送，点击礼物可直接送出哦，快去试试吧~";
    titleL.textColor = UIColor.whiteColor;
    [titleL sizeToFit];
    [content addSubview:titleL];
    
//    // 将电话告知您验证码，请注意接听！
//    UILabel *detailL = [[UILabel alloc] init];
//    detailL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kSCALE(14)];
//    detailL.textColor = UIColor.blackColor;
//    detailL.text = @"将电话告知您验证码，请注意接听！";
//    [detailL sizeToFit];
//    [content addSubview:detailL];
//
//    // 横线
//    UIView *line = [UIView new];
//    line.backgroundColor = RGBColor(0xd9d9d9);
//    [content addSubview:line];
    
    // 知道了
    UIButton *knowB = [[UIButton alloc] init];
    [knowB setTitle:@"知道了" forState:UIControlStateNormal];
    [knowB setTitleColor:WhiteColor forState:UIControlStateNormal];
    [knowB.titleLabel setFont:FontSize16];
    [knowB addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    knowB.backgroundColor = [UIColor colorWithHex:@"#5462E8"];
    knowB.layer.cornerRadius = 40/2;
    knowB.layer.masksToBounds = YES;
    [content addSubview:knowB];
    
    //
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(280, 184));
        make.center.equalTo(self.view);
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content).offset(34);
        make.right.equalTo(content).offset(-34);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(38);
        make.centerX.equalTo(content);
    }];
    
//    [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(kSCALE(14));
//        make.top.mas_equalTo(titleL.mas_bottom).offset(12);
//        make.centerX.equalTo(content);
//    }];
//
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(kOnePx);
//        make.left.right.equalTo(content);
//        make.top.mas_equalTo(detailL.mas_bottom).offset(kSCALE(23));
//    }];
    
    [knowB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content).offset(34);
        make.right.equalTo(content).offset(-34);
        make.bottom.equalTo(content).offset(-25);
        make.height.mas_equalTo(40);
    }];
}

- (void)dismiss:(UIButton*)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(ZZWPopAlertViewController:tapSureButton:)]) {
        [_delegate ZZWPopAlertViewController:self tapSureButton:btn];
    }
    
}


@end
