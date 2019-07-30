//
//  LYLogConst.h
//  LYMoodDiaryMaker
//
//  Created by liyong yuan on 2019/7/30.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#ifndef LYLogConst_h
#define LYLogConst_h

#ifdef DEBUG
#define LYLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* LYLogConst_h */
