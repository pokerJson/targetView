//
//  ViewController.m
//  查找公共View
//
//  Created by dzc on 2021/3/4.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


/// 获取摸个view的富view，利用superView一层层往上找
/// @param view 传进来的view
- (NSArray *)getSuperViews:(UIView *)view{
    if (view == nil) {
        return @[];
    }
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    while (view != nil) {
        [arr addObject:view];
        view = view.superview;
    }
    return  arr;
}

#pragma mark - 查找两个view的最近公共父视图 方法1
- (UIView *)getNearestSuperViewWithView1:(UIView *)view1 andView2:(UIView *)view2{
    //分别拿到view的所有父视图
    NSArray *arr1 = [self getSuperViews:view1];
    NSArray *arr2 = [self getSuperViews:view2];
    //两层循环 时间复杂度O(n^2)
    for (int i = 0; i<arr1.count; i++) {
        UIView *targetView = arr1[i];
        for (int j = 0; j<arr2.count; j++) {
            if (targetView == arr2[j]) {
                return targetView;
            }
        }
    }
    return nil;
}


#pragma mark - 查找两个view的最近公共父视图 方法2
/// 利用nsset查找元素，整体一个for循环，时间复杂度O(N)
- (UIView *)getNearestSuperView2WithView1:(UIView *)view1 andView2:(UIView *)view2{
    //分别拿到view的所有父视图
    NSArray *arr1 = [self getSuperViews:view1];
    NSArray *arr2 = [self getSuperViews:view2];
    //利用nsset，类似数组，只是set里面是无序的hash表实现的，查找元素比数组更快 整体的时间复杂度O(N) 一次循环
    NSSet *set = [NSSet setWithArray:arr2];
    for (int i = 0; i<arr1.count; i++) {
        UIView *targetView = arr1[i];
        if ([set containsObject:targetView]) {
            return targetView;
        }
    }
    return nil;
}

#pragma mark - 查找两个view的最近公共父视图 方法3  《这个方式适合深度一样的两个数组》
/// 类似归并排序的思想，用两个「指针」，分别指向两个路径的根节点（倒叙输出的，根节点就是view1的第一个superview），然后从根节点开始，找第一次相同的 时间复杂度类似O(N)
/// 结合二叉树看
- (UIView *)getNearestSuperView3WithView1:(UIView *)view1 andView2:(UIView *)view2{
    //分别拿到view的所有父视图
    NSArray *arr1 = [self getSuperViews:view1];
    NSArray *arr2 = [self getSuperViews:view2];
    NSInteger p1 = arr1.count - 1;
    NSInteger p2 = arr2.count - 1;
    UIView *tatgetView = nil;
    while (p1 >= 0 && p2 >= 0) {
        if (arr1[p1] == arr2[p2]) {
            tatgetView = arr1[p1];
        }
        p1--;
        p2--;
    }
    return tatgetView;

}
@end
