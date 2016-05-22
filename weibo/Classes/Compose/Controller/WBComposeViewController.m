//
//  WBComposeViewController.m
//  weibo
//
//  Created by afei on 16/1/31.
//  Copyright © 2016年 afei. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "WBComposeToolbar.h"
#import "WBComposePhotosView.h"
#import "WBHttpTool.h"//暂时未封装WBStatusTool类
#import "WBEmotionKeyboard.h"
#import "WBEmotion.h"
#import "WBEmotionTextView.h"

@interface WBComposeViewController ()<UITextViewDelegate, WBComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) WBEmotionTextView *textView;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) WBComposeToolbar *toolbar;
/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) WBComposePhotosView *photosView;
#warning 一定要用strong
/** 表情键盘 */
@property (nonatomic, strong) WBEmotionKeyboard *emotionKeyboard;
/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeybaord;

@end

@implementation WBComposeViewController

#pragma mark - 懒加载

- (WBEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[WBEmotionKeyboard alloc] init];
        // 键盘的宽度
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
        
        // 如果键盘宽度不为0，那么系统就会强制让键盘的宽度等于屏幕的宽度：320
        //        if (self.emotionKeyboard.width > 0) {
        //            self.emotionKeyboard.width = [UIScreen mainScreen].bounds.size.width;
        //        }
    }
    return _emotionKeyboard;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolbar];
    
    // 添加photosView
    [self setupPhotosView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘）
    [self.textView becomeFirstResponder];
}


- (void)dealloc
{
    [WBNotificationCenter removeObserver:self];
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *prefix = @"发微博";
    NSString *name = [WBAccountTool account].name;
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        //titleView.backgroundColor = WBRandomColor;
        // 自动换行
        titleView.numberOfLines = 0;
        titleView.y = 50;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        
        // 创建一个带有属性的字符串（比如颜色属性、字体属性等文字属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        // 添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}

/**
 *  添加textView
 */
- (void)setupTextView
{
    // 1.添加
    WBEmotionTextView *textView = [[WBEmotionTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事...😄";
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    // 2.监听textView文字改变的通知
    [WBNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3.监听键盘的通知
    [WBNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [WBNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 表情选中的通知
    [WBNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:WBEmotionDidSelectNotification object:nil];
    // 删除文字的通知
    [WBNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:WBEmotionDidDeleteNotification object:nil];
}

#pragma mark - 监听方法
/**
 *  删除文字
 */
- (void)emotionDidDelete
{
    [self.textView deleteBackward];
}

/**
 *  表情被选中了
 */
- (void)emotionDidSelect:(NSNotification *)notification
{
    WBEmotion *emotion = notification.userInfo[WBSelectEmotionKey];
    [self.textView insertEmotion:emotion];
}

/**
 *  添加toolbar
 */
- (void)setupToolbar
{
    WBComposeToolbar *toolbar = [[WBComposeToolbar alloc] init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 *  添加photosView
 */
- (void)setupPhotosView
{
    WBComposePhotosView *photosView = [[WBComposePhotosView alloc] init];
    CGFloat photosW = self.textView.frame.size.width;
    CGFloat photosH = self.textView.frame.size.height;
    CGFloat photosY = 80;
    photosView.frame = CGRectMake(0, photosY, photosW, photosH);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(WBComposeToolbar *)toolbar didClickedButton:(WBComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case WBComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case WBComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibrary];
            break;
            
        case WBComposeToolbarButtonTypeMention: // @
            WBLog(@"--- @");
            break;
            
        case WBComposeToolbarButtonTypeTrend: // #
            WBLog(@"--- #");
            break;
  
        case WBComposeToolbarButtonTypeEmotion:// 表情\键盘
            [self switchKeyboard];
            break;
    }
}

/**
 *  切换键盘
 */
- (void)switchKeyboard
{
    // self.textView.inputView == nil : 使用的是系统自带的键盘
    if (self.textView.inputView == nil) { // 切换为自定义的表情键盘
        self.textView.inputView = self.emotionKeyboard;
        
        // 显示键盘按钮
        self.toolbar.showKeyboardButton = YES;
    } else { // 切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情按钮
        self.toolbar.showKeyboardButton = NO;
    }
    
    // 开始切换键盘
    self.switchingKeybaord = YES;
    
    // 退出键盘
    [self.textView endEditing:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出键盘
        [self.textView becomeFirstResponder];
        
        // 结束切换键盘
        self.switchingKeybaord = NO;
    });
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
    
    NSLog(@"%@", info);
}

/**
 *  监听文字改变
 */
- (void)textDidChange
{
    
   self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

#pragma mark - 监听方法
/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 如果正在切换键盘，就不要执行后面的代码
    //if (self.switchingKeybaord) return;
    
    NSDictionary *userInfo = notification.userInfo;
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
}

/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发微博
 */
- (void)send
{
    if (self.photosView.totalImages.count) { // 有图片
        [self sendWithImage];
    } else { // 没有图片
        [self sendWithoutImage];
    }
    
    // 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发有图片的微博
 */
- (void)sendWithImage
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.fullText;
    params[@"access_token"] = [WBAccountTool account].access_token;
    
    // 2.封装文件参数
    NSMutableArray *formDataArray = [NSMutableArray array];
    NSArray *images = [self.photosView totalImages];
    for (UIImage *image in images) {
        IWFormData *formData = [[IWFormData alloc] init];
        formData.data = UIImageJPEGRepresentation(image, 0.000001);
        formData.name = @"pic";
        formData.mimeType = @"image/jpeg";
        formData.filename = @"";
        [formDataArray addObject:formData];
    }
    
    // 3.发送请求
    [WBHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params formDataArray:formDataArray success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

/**
 *  发没有图片的微博
 */
- (void)sendWithoutImage
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.fullText;
    params[@"access_token"] = [WBAccountTool account].access_token;
    
    // 2.发送请求
    [WBHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

@end
