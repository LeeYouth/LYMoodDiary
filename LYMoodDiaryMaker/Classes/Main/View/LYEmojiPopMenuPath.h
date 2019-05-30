//
//  LYEmojiPopMenuPath.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/15.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LYPopupMenuArrowDirection) {
    LYPopupMenuArrowDirectionTop = 0,  //箭头朝上
    LYPopupMenuArrowDirectionBottom,   //箭头朝下
    LYPopupMenuArrowDirectionLeft,     //箭头朝左
    LYPopupMenuArrowDirectionRight,    //箭头朝右
    LYPopupMenuArrowDirectionNone      //没有箭头
};

@interface LYEmojiPopMenuPath : NSObject

+ (CAShapeLayer *)ly_maskLayerWithRect:(CGRect)rect
                            rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(LYPopupMenuArrowDirection)arrowDirection;

+ (UIBezierPath *)ly_bezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(LYPopupMenuArrowDirection)arrowDirection;

@end

NS_ASSUME_NONNULL_END
