//
//  LYRectConst.h
//  LYMoodDiaryMaker
//
//  Created by CNFOL_iOS on 2019/5/15.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_STATIC_INLINE CGFloat LYRectWidth(CGRect rect)
{
    return rect.size.width;
}

UIKIT_STATIC_INLINE CGFloat LYRectHeight(CGRect rect)
{
    return rect.size.height;
}

UIKIT_STATIC_INLINE CGFloat LYRectX(CGRect rect)
{
    return rect.origin.x;
}

UIKIT_STATIC_INLINE CGFloat LYRectY(CGRect rect)
{
    return rect.origin.y;
}

UIKIT_STATIC_INLINE CGFloat LYRectTop(CGRect rect)
{
    return rect.origin.y;
}

UIKIT_STATIC_INLINE CGFloat LYRectBottom(CGRect rect)
{
    return rect.origin.y + rect.size.height;
}

UIKIT_STATIC_INLINE CGFloat LYRectLeft(CGRect rect)
{
    return rect.origin.x;
}

UIKIT_STATIC_INLINE CGFloat LYRectRight(CGRect rect)
{
    return rect.origin.x + rect.size.width;
}





