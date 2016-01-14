//
//  CoreDataManager.h
//  02-DBManager
//
//  Created by kangkathy on 15/9/2.
//  Copyright (c) 2015年 kangkathy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

@property(nonatomic, strong)NSManagedObjectContext *context;

//单例类
+ (instancetype)defaultManager;


//1.配置CoreData相关内容
- (void)configureCoreDataInformation;

//2.添加操作,为了通用性，把参数设置成父类指针
- (void)addManageObject:(NSManagedObject *)mo;

//3.查询
- (NSArray *)queryObject:(NSString *)entityName predicate:(NSPredicate *)predicate;

//4.删除
- (void)deleteObject:(NSManagedObject *)mo;

// 创建MO对象
- (NSManagedObject *)createMO:(NSString *)entityName;

@end
