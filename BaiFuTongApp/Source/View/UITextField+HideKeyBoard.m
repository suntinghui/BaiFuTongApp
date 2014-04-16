#import "UITextField+HideKeyBoard.h"

@implementation UITextField (HideKeyBoard)

- (void) hideKeyBoard:(UIView*)view:(NSInteger)index hasNavBar:(BOOL)hasNavBar{//关于隐藏键盘; index 表示键盘取消时哪个view下移
    UITapGestureRecognizer *tap = nil;
    switch (index) {
        case 1:
        {
            tap = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(doHideKeyBoardOne:)];
            break;
        }
        case 2:
        {
            if (hasNavBar) {
                tap = [[UITapGestureRecognizer alloc]
                       initWithTarget:self
                       action:@selector(doHideKeyBoardTwo:)];
            }else{
                tap = [[UITapGestureRecognizer alloc]
                       initWithTarget:self
                       action:@selector(doHideKeyBoardTwoNoNav:)];
            }
            
            break;
        }
        case 3:
        {
            tap = [[UITapGestureRecognizer alloc]
                   initWithTarget:self
                   action:@selector(doHideKeyBoardThree:)];
            break;
        }
        default:
            break;
    }
    
    tap.numberOfTapsRequired = 1;
    [view  addGestureRecognizer: tap];
    [tap setCancelsTouchesInView:NO];
}

- (void)doHideKeyBoardOne:(id)view{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //原来写的
//    CGRect rect = CGRectMake(0.0f, 0.0f,320,416);
    //iphone5适配更改为下　by xs　2013/09/12
    CGRect rect = CGRectMake(0.0f, 40.0f,320,[UIScreen mainScreen].bounds.size.height -104);
    self.superview.frame = rect;
    [UIView commitAnimations];
    
}
- (void)doHideKeyBoardTwo:(id)view{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 40.0f,320,416);
    //iphone5适配更改为下　by xs　2013/09/12
    CGRect rect = CGRectMake(0.0f, 40.0f,320,[UIScreen mainScreen].bounds.size.height -104);
    self.superview.superview.frame = rect;
    [UIView commitAnimations];
    
}
- (void)doHideKeyBoardTwoNoNav:(id)view{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 0.0f,320,460);
    //iphone5适配更改为下　by xs　2013/09/12
    CGRect rect = CGRectMake(0.0f, 0.0f,320,[UIScreen mainScreen].bounds.size.height -20);
    self.superview.superview.frame = rect;
    [UIView commitAnimations];
    
}
- (void)doHideKeyBoardThree:(id)view{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 0.0f,320,460);
    //iphone5适配更改为下　by xs　2013/09/12
    CGRect rect = CGRectMake(0.0f, 0.0f,320,[UIScreen mainScreen].bounds.size.height -20);
    self.superview.superview.superview.frame = rect;
    [UIView commitAnimations];
    
}
@end
