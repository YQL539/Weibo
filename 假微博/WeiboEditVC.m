//
//  WeiboEditVC.m
//  假微博
//
//  Created by yangqinglong on 16/4/11.
//  Copyright © 2016年 杨清龙. All rights reserved.
//

#import "WeiboEditVC.h"
#import "WeiboManager.h"
@interface WeiboEditVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *editTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation WeiboEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.editTextView.layer.borderWidth = 0.5;
    self.editTextView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.editTextView becomeFirstResponder];
}

- (IBAction)CancelDIdClicked:(id)sender {
    [self.editTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SendDidClicked:(id)sender {
    [self.editTextView resignFirstResponder];
    if (_imageView.image == nil) {
        [[WeiboManager shareManager] sendWeiboWithText:self.editTextView.text];
    }else{
        NSData *picData = UIImagePNGRepresentation(_imageView.image);
        [[WeiboManager shareManager]sendWeiboWithText:self.editTextView.text Pic:picData];
    }
    [WeiboManager shareManager].WeiboSendIsFinishedBlock = ^(){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"微博发送成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    };
}
- (IBAction)addPic:(id)sender {
    [self.editTextView resignFirstResponder];
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.editTextView resignFirstResponder];
}

#pragma mark ----------uiTextViewDelegate-----------



@end














