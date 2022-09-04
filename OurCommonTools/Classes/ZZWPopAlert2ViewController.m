//
//  ZZWPopAlert2ViewController.m
//  botella
//
//  Created by coding on 2022/8/4.
//

#import "ZZWPopAlert2ViewController.h"

@interface ZZWPopAlert2ViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation ZZWPopAlert2ViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // 这一步非常重要
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView.layer.cornerRadius = 16.0;
    self.bgView.layer.masksToBounds = YES;
    [self.cancelBtn setTitleColor:[UIColor colorWithHex:@"#CECECE" alpha:0.6] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)cancelAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(ZZWPopAlert2ViewController:tapCancelButton:)]) {
        [_delegate ZZWPopAlert2ViewController:self tapCancelButton:sender];
    }
}

- (IBAction)sureAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(ZZWPopAlert2ViewController:tapSureButton:)]) {
        [_delegate ZZWPopAlert2ViewController:self tapSureButton:sender];
    }
}

@end
