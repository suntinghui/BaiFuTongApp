//
//  RandomKeyBoardView.h
//  RandomKeyBoard
//
//  Created by jia liao on 7/8/12.
//  Copyright (c) 2012 huaihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RandomKeyBoardDelegate <NSObject>

- (void) numberKeyBoardInput:(NSInteger) number;
- (void) numberKeyBoardDelete;
- (void) numberKeyBoardConfim;
- (void) numberKeyBoardClear;
- (void) numberKeyBoardAbout;
@end

@interface RandomKeyBoardView : UIView
{
@private
    __weak id<RandomKeyBoardDelegate> _delegate;
}
@property(nonatomic, weak)id<RandomKeyBoardDelegate>delegate;

-(void)refresh:(id)sender;

@end
