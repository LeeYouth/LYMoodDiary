//
//  LYEmojiPopMenuPath.m
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/15.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYEmojiPopMenuPath.h"
#import "LYRectConst.h"

@implementation LYEmojiPopMenuPath

+ (CAShapeLayer *)ly_maskLayerWithRect:(CGRect)rect
rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(LYPopupMenuArrowDirection)arrowDirection
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self ly_bezierPathWithRect:rect rectCorner:rectCorner cornerRadius:cornerRadius borderWidth:0 borderColor:nil backgroundColor:nil arrowWidth:arrowWidth arrowHeight:arrowHeight arrowPosition:arrowPosition arrowDirection:arrowDirection].CGPath;
    return shapeLayer;
}


+ (UIBezierPath *)ly_bezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(LYPopupMenuArrowDirection)arrowDirection
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (borderColor) {
        [borderColor setStroke];
    }
    if (backgroundColor) {
        [backgroundColor setFill];
    }
    bezierPath.lineWidth = borderWidth;
    rect = CGRectMake(borderWidth / 2, borderWidth / 2, LYRectWidth(rect) - borderWidth, LYRectHeight(rect) - borderWidth);
    CGFloat topRightRadius = 0,topLeftRadius = 0,bottomRightRadius = 0,bottomLeftRadius = 0;
    CGPoint topRightArcCenter,topLeftArcCenter,bottomRightArcCenter,bottomLeftArcCenter;
    
    if (rectCorner & UIRectCornerTopLeft) {
        topLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerTopRight) {
        topRightRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomLeft) {
        bottomLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomRight) {
        bottomRightRadius = cornerRadius;
    }
    
    if (arrowDirection == LYPopupMenuArrowDirectionTop) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LYRectX(rect), arrowHeight + topLeftRadius + LYRectX(rect));
        topRightArcCenter = CGPointMake(LYRectWidth(rect) - topRightRadius + LYRectX(rect), arrowHeight + topRightRadius + LYRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) - bottomLeftRadius + LYRectX(rect));
        bottomRightArcCenter = CGPointMake(LYRectWidth(rect) - bottomRightRadius + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius + LYRectX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > LYRectWidth(rect) - topRightRadius - arrowWidth / 2) {
            arrowPosition = LYRectWidth(rect) - topRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition - arrowWidth / 2, arrowHeight + LYRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, LYRectTop(rect) + LYRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition + arrowWidth / 2, arrowHeight + LYRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) - topRightRadius, arrowHeight + LYRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius - LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) + LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectX(rect), arrowHeight + topLeftRadius + LYRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        
    }else if (arrowDirection == LYPopupMenuArrowDirectionBottom) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LYRectX(rect),topLeftRadius + LYRectX(rect));
        topRightArcCenter = CGPointMake(LYRectWidth(rect) - topRightRadius + LYRectX(rect), topRightRadius + LYRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) - bottomLeftRadius + LYRectX(rect) - arrowHeight);
        bottomRightArcCenter = CGPointMake(LYRectWidth(rect) - bottomRightRadius + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius + LYRectX(rect) - arrowHeight);
        if (arrowPosition < bottomLeftRadius + arrowWidth / 2) {
            arrowPosition = bottomLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > LYRectWidth(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = LYRectWidth(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition + arrowWidth / 2, LYRectHeight(rect) - arrowHeight + LYRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, LYRectHeight(rect) + LYRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition - arrowWidth / 2, LYRectHeight(rect) - arrowHeight + LYRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) - arrowHeight + LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectX(rect), topLeftRadius + LYRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) - topRightRadius + LYRectX(rect), LYRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius - LYRectX(rect) - arrowHeight)];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
    }else if (arrowDirection == LYPopupMenuArrowDirectionLeft) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LYRectX(rect) + arrowHeight,topLeftRadius + LYRectX(rect));
        topRightArcCenter = CGPointMake(LYRectWidth(rect) - topRightRadius + LYRectX(rect), topRightRadius + LYRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LYRectX(rect) + arrowHeight, LYRectHeight(rect) - bottomLeftRadius + LYRectX(rect));
        bottomRightArcCenter = CGPointMake(LYRectWidth(rect) - bottomRightRadius + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius + LYRectX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > LYRectHeight(rect) - bottomLeftRadius - arrowWidth / 2) {
            arrowPosition = LYRectHeight(rect) - bottomLeftRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowHeight + LYRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(LYRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + LYRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + LYRectX(rect), topLeftRadius + LYRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) - topRightRadius, LYRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius - LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) + LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        
    }else if (arrowDirection == LYPopupMenuArrowDirectionRight) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LYRectX(rect),topLeftRadius + LYRectX(rect));
        topRightArcCenter = CGPointMake(LYRectWidth(rect) - topRightRadius + LYRectX(rect) - arrowHeight, topRightRadius + LYRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) - bottomLeftRadius + LYRectX(rect));
        bottomRightArcCenter = CGPointMake(LYRectWidth(rect) - bottomRightRadius + LYRectX(rect) - arrowHeight, LYRectHeight(rect) - bottomRightRadius + LYRectX(rect));
        if (arrowPosition < topRightRadius + arrowWidth / 2) {
            arrowPosition = topRightRadius + arrowWidth / 2;
        }else if (arrowPosition > LYRectHeight(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = LYRectHeight(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(LYRectWidth(rect) - arrowHeight + LYRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) + LYRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) - arrowHeight + LYRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) - arrowHeight + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius - LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) + LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectX(rect), arrowHeight + topLeftRadius + LYRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) - topRightRadius + LYRectX(rect) - arrowHeight, LYRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        
    }else if (arrowDirection == LYPopupMenuArrowDirectionNone) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LYRectX(rect),  topLeftRadius + LYRectX(rect));
        topRightArcCenter = CGPointMake(LYRectWidth(rect) - topRightRadius + LYRectX(rect),  topRightRadius + LYRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) - bottomLeftRadius + LYRectX(rect));
        bottomRightArcCenter = CGPointMake(LYRectWidth(rect) - bottomRightRadius + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius + LYRectX(rect));
        [bezierPath moveToPoint:CGPointMake(topLeftRadius + LYRectX(rect), LYRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) - topRightRadius, LYRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectWidth(rect) + LYRectX(rect), LYRectHeight(rect) - bottomRightRadius - LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + LYRectX(rect), LYRectHeight(rect) + LYRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LYRectX(rect), arrowHeight + topLeftRadius + LYRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
    }
    
    [bezierPath closePath];
    return bezierPath;
}

@end
