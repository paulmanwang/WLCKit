//
//  WLCAnimation.m
//  MyDemos
//
//  Created by lichunwang on 16/11/15.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCAnimation.h"

static NSMutableDictionary *animationMap = nil;

@interface WLCAnimation ()<CAAnimationDelegate>

@property (weak, nonatomic) UIView *animView;
@property (assign, nonatomic) CGFloat angle;

@end

@implementation WLCAnimation

+ (void)initialize
{
    animationMap = [NSMutableDictionary new];
}

- (NSString *)addressStringOfObject:(id)object
{
    NSLog(@"object = %@", object);
    return [NSString stringWithFormat:@"%@", [NSValue valueWithNonretainedObject:object]];
}

- (void)addRotationAnimationForView:(UIView *)view angle:(CGFloat)angle duration:(CFTimeInterval)duration
{
    self.animView = view;
    self.angle = angle;
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani.toValue = @(angle);
    ani.duration = duration;
    // ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    ani.delegate = self;
    [ani setValue:@"Rotation" forKey:@"AnimationType"];
    [view.layer addAnimation:ani forKey:@"RotationAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
//    NSString *type = [anim valueForKey:@"AnimationType"];
//    if ([type isEqualToString:@"Rotation"]) {
//        [self.animView.layer removeAnimationForKey:@"RotationAnimation"];
//        
//    }
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
    
    CGAffineTransform tranform = CGAffineTransformMakeRotation(self.angle);
    self.animView.transform = tranform;
    [self.animView.layer removeAnimationForKey:@"RotationAnimation"]; // 这一行代码不能去掉，不然效果不好
    
//    [CATransaction commit];
}

@end
