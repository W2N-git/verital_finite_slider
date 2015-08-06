//
//  VerticalFiniteSlider.h
//  VerticalFiniteSlider
//
//  Created by Anton Belousov on 05/08/15.
//  Copyright (c) 2015 novilab-mobile. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface VerticalFiniteSlider : UIControl

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *leftMarks;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *rightMarks;


@property (nonatomic, strong) UISlider *slider;
//TESTS ONLY
@property (nonatomic) IBInspectable NSUInteger selectedIndex;
@property (nonatomic) IBInspectable NSUInteger numberOfindexes;

- (float)relativeYForIndex:(NSUInteger)index;

@end
