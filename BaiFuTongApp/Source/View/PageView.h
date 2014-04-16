//
//  PageView.h
//  POS2iPhone
//
//  Created by jia liao on 1/16/13.
//  Copyright (c) 2013 RYX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PageDelegate  <NSObject>

@required//这个可以是required，也可以是optional
-(void)firstPageButtonAction;
-(void)previousPageButtonAction;
-(void)nextPageButtonAction;
-(void)lastPageButtonAction;

@end
@interface PageView : UIView

@property(nonatomic, strong)UILabel *pageCountLabel;
@property(nonatomic, strong) id < PageDelegate > delegate;

-(void)setNumerator:(NSString*)numerator denominator:(NSString*)denominator;
@end
