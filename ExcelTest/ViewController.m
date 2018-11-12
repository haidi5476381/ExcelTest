//
//  ViewController.m
//  ExcelTest
//
//  Created by deng-HaiDi on 2018/11/9.
//  Copyright © 2018年 deng-HaiDi. All rights reserved.
//

#import "ViewController.h"
#import "QuickExcelReaderUtil.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sheet1" ofType:@"text"];
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:nil];
//
//    NSString *newPath = [NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] bundlePath],@"/address.plist" ];
//    NSLog(@"newPath = %@", newPath);
    
//    [array writeToFile:newPath atomically:YES];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"xlsx"];
//    [QuickExcelReaderUtil readExcelWithPath:path complete:^(NSDictionary<NSString*, NSArray<ZContent*>*>* results, NSError* error) {
//
//        NSArray *array = results[@"Sheet1"];
//        for(ZContent * content in array) {
//
//            NSLog(@"keyName = %@,keyValue =%@",content.keyName,content.value);
//
//
//        }
//    }];
    // Do any additional setup after loading the view, typically from a nib.
    // path
     NSString *path = [[NSBundle mainBundle] pathForResource:@"Sheet1" ofType:@"txt"];
        // UTF-8
       NSString *contents = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
      // 字符串拆分
      NSArray *contentsArray = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
      // 存储位置
     NSString *docs = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tiaoxingma.plist"] ;
//     NSString *docs = [[NSBundle mainBundle] pathForResource:@"ub" ofType:@"plist"];
       // 定义数组
      NSMutableArray *arr = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
 
        NSInteger idx;
      for (idx = 0; idx < contentsArray.count; idx++) {
                NSString* currentContent = [contentsArray objectAtIndex:idx];
               // 字符串拆分 制表符
               NSArray* timeDataArr = [currentContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"="]];
       
          
          if(timeDataArr.count > 1) {
          NSString *time0 = [timeDataArr objectAtIndex:0];
           NSArray  *time0Array = [time0 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
              time0 = [time0Array objectAtIndex:1];
          NSString *time1 = [timeDataArr objectAtIndex:1];
            NSArray *time1Array = [time1 componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
         time1 = [time1Array objectAtIndex:1];
          if (time0.length > 1) {
              
              NSMutableDictionary *copyDict = [dic copy];
              
              [copyDict enumerateKeysAndObjectsUsingBlock:^(NSString *keyValue2,NSString *valusStr2,BOOL *stoop2){
                  
                  if ([keyValue2 isEqualToString:time0]) {
                            NSLog(@"key = %@,value = %@",keyValue2,valusStr2);
                      NSLog(@"key = %@,value = %@",time0,time1);
                      if (valusStr2.length < time1.length) {
                          [dic setValue:time1 forKey:time0];
                      }
                  }else{
                     [dic setValue:time1 forKey:time0];
                  }
                  
                  
              }];
            
              
              if (idx == 0) {
                   [dic setValue:time1 forKey:time0];
              }
//             [dic setValue:time1 forKey:time0];
            
      
              
          
          }
          
        
//                 [arr addObject:dic];
           }
      }
    

  
      // 数据写入plist文件
//       [arr writeToFile:docs atomically:YES];
    [dic writeToFile:docs atomically:YES];
}


@end
