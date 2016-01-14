//
//  CoreDataManager.m
//  02-DBManager
//
//  Created by kangkathy on 15/9/2.
//  Copyright (c) 2015年 kangkathy. All rights reserved.
//

#import "CoreDataManager.h"
#define kDataModel @"VideoModel"

@implementation CoreDataManager

+ (instancetype)defaultManager {
    
    static CoreDataManager *instance = nil;
    
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
        
        //初始化CoreData的操作
        [instance configureCoreDataInformation];
    });
    
    return  instance;

}

- (void)configureCoreDataInformation {
    
    //1.加载数据模型文件,由数据模型文件来构建ManagedObjectModel数据模型对象。
    NSURL *url = [[NSBundle mainBundle] URLForResource:kDataModel withExtension:@"momd"];
    NSManagedObjectModel *dataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    
    //2.创建PSC对象，它是外部物理文件和应用程序之间的桥梁，通过些对象来将数据保存到外部物理文件中。
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:dataModel];
    //在沙盒路径下设置SQLite数据库文件
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/CoreData.rdb"];
    NSLog(@"%@", filePath);
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    //把psc和数据库文件关联,设置CoreData存储数据的方式为SQLite数据库
    
    NSError *error = nil;
    [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileURL options:nil error:&error];
    if (error) {
        NSLog(@"打开数据库文件失败：%@", error);
    }
    else {
        NSLog(@"打开数据库文件成功");
    }
    
    
    //3.创建Context对象，所有对于MO的处理，都是在context完成，需要把context和PSC建立关联,才能实现数据持久化。
    self.context = [[NSManagedObjectContext alloc] init];
    self.context.persistentStoreCoordinator = psc;

    
}
//创建实体对象
- (NSManagedObject *)createMO:(NSString *)entityName {
    
    if (entityName.length == 0) {
        return nil;
    }
    
    NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_context];
    
    return mo;
    
}
//添加实体
- (void)addManageObject:(NSManagedObject *)mo {
    
    //把mo对象添加到context上
    [self.context insertObject:mo];
    
    NSError *error = nil;
    
    if ([self.context save:&error]) {
        NSLog(@"保存成功");
    }
    else {
        NSLog(@"保存失败:%@", error);
    }
    
}
//查找实体
- (NSArray *)queryObject:(NSString *)entityName predicate:(NSPredicate *)predicate {
    if (entityName.length == 0) {
        return nil;
    }
    
    //1.创建请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    if (predicate) {
        
        request.predicate = predicate;
    }
    
    //3.让context执行查询操作,返回数组作为查询结果
    NSArray *array = [_context executeFetchRequest:request error:nil];
    
    
    return array;
}

- (void)deleteObject:(NSManagedObject *)mo {
    
    [_context deleteObject:mo];
    
    NSError *error = nil;

    if ([self.context save:&error]) {
        NSLog(@"删除成功");
    }
    else {
        NSLog(@"删除失败:%@", error);
    }
    
}



@end
