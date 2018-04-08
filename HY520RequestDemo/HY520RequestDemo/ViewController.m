//
//  ViewController.m
//  HY520RequestDemo
//
//  Created by BigDataAi on 2018/2/26.
//  Copyright © 2018年 BigDataAi. All rights reserved.
//

#import "ViewController.h"
#import "HYRequestManager.h"
#import <BarrageRenderer/BarrageRenderer.h>

@interface ViewController ()<BarrageRendererDelegate>

@property (nonatomic,strong) BarrageRenderer *barrageRenderer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [HYRequestManager monitoringReachabilityStatusChangeBlock:^(HYReachabilityStatus status) {
        
    }];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 250)];
    [self.view addSubview:barView];
    
    self.barrageRenderer = [[BarrageRenderer alloc] init];
    self.barrageRenderer.delegate = self;
    [barView addSubview:self.barrageRenderer.view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0.f, 0.f, 85.f, 35.f);
    button.center = self.view.center;
    button.tag = 1000;
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = 10.f;
    button.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)sender {
    if (sender.tag == 1000) {
        [self.barrageRenderer start];
        sender.tag = 1001;
        for (int i = 0; i < 30; i++) {
            [self.barrageRenderer receive:[self createTextSpriteDescriptorWithDirection:BarrageWalkDirectionR2L side:BarrageWalkSideDefault count:i]];
        }
    } else {
        sender.tag = 1000;
        [self.barrageRenderer stop];
    }
}

- (BarrageDescriptor *)createTextSpriteDescriptorWithDirection:(BarrageWalkDirection)direction side:(BarrageWalkSide)side count:(int)count {
    BarrageDescriptor *descriptor = [[BarrageDescriptor alloc] init];
    descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
    descriptor.params[@"text"] = [NSString stringWithFormat:@"单独行动 %d",count];
    descriptor.params[@"direction"] = @(direction);
    descriptor.params[@"side"] = @(side);
    descriptor.params[@"speed"] = @(100 * (double)random()/RAND_MAX + 60);
    descriptor.params[@"delay"] = @(count * 0.2);
    
    return descriptor;
}

#pragma mark -- BarrageRendererDelegate
- (void)barrageRenderer:(BarrageRenderer *)renderer spriteStage:(BarrageSpriteStage)stage spriteParams:(NSDictionary *)params {
    if (stage == BarrageSpriteStageEnd) {
        BarrageDescriptor *descriptor = [[BarrageDescriptor alloc] init];
        descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);
        [descriptor.params addEntriesFromDictionary:params];
        descriptor.params[@"delay"] = @(0);
        [renderer receive:descriptor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
