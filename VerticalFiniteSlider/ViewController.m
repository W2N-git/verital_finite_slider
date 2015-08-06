//
//  ViewController.m
//  VerticalFiniteSlider
//
//  Created by Anton Belousov on 05/08/15.
//  Copyright (c) 2015 novilab-mobile. All rights reserved.
//

#import "ViewController.h"
#import "VerticalFiniteSlider.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet VerticalFiniteSlider *verticalSlider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)verticalSlider:(VerticalFiniteSlider *)sender {
    NSLog(@"%s, LINE:%d, current index: %lu", __PRETTY_FUNCTION__, __LINE__, (unsigned long)sender.selectedIndex);
    NSLog(@"%s, LINE:%d, y: %f", __PRETTY_FUNCTION__, __LINE__, [sender relativeYForIndex:sender.selectedIndex]);
}

@end
