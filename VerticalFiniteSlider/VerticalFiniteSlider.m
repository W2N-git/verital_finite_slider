//
//  VerticalFiniteSlider.m
//  VerticalFiniteSlider
//
//  Created by Anton Belousov on 05/08/15.
//  Copyright (c) 2015 novilab-mobile. All rights reserved.
//

#import "VerticalFiniteSlider.h"

#define DEFAULT_MIN_VALUE 0
#define DEFAULT_MAX_VALUE 1
#define DEFAULT_HORIZONTAL_PADDING_TO_MARKS 40

@implementation VerticalFiniteSlider

- (void)layoutSubviews {
    
    if (self.slider == nil) {
        UISlider *slider = [UISlider new];
        slider.transform = CGAffineTransformMakeRotation(M_PI_2);
        
        [slider addTarget:self action:@selector(sliderChangedValue) forControlEvents:UIControlEventValueChanged];
        
        self.slider = slider;
        
        [self updateSliderValue];
        [self addSubview:slider];
    }
    
    CGRect frame      = self.slider.frame;
    frame.size.height = self.frame.size.height;
    frame.origin.x    = self.bounds.size.width/2  - frame.size.width/2;
    frame.origin.y    = self.bounds.size.height/2 - frame.size.height/2;
    self.slider.frame = frame;
    
    [self placeLeftMarks];
    [self placeRightMarks];
    [super layoutSubviews];
}

- (void)placeLeftMarks {
    for (NSInteger i = 0; i < self.leftMarks.count; i++) {
        UIView *view      = self.leftMarks[i];
        UIView *superview = view.superview;
        [view removeFromSuperview];
        
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        CGFloat y = [self relativeYForIndex:i];
        [superview addSubview:view];

        [superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.slider
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:y]];
        
        [superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.slider
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:-DEFAULT_HORIZONTAL_PADDING_TO_MARKS]];
        
        [view.superview setNeedsLayout];
        [view.superview layoutIfNeeded];
        
        NSLog(@"%s, LINE:%d, frame: %@", __PRETTY_FUNCTION__, __LINE__, NSStringFromCGRect(view.frame));
    }
}

- (void)placeRightMarks {
    
    for (NSInteger i = 0; i < self.rightMarks.count; i++) {
        UIView *view      = self.rightMarks[i];
        UIView *superview = view.superview;
        [view removeFromSuperview];
        
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        CGFloat y = [self relativeYForIndex:i];
        [superview addSubview:view];
        
        [superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.slider
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:y]];
        
        [superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.slider
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:DEFAULT_HORIZONTAL_PADDING_TO_MARKS]];
        
        [view.superview setNeedsLayout];
        [view.superview layoutIfNeeded];
        
        NSLog(@"%s, LINE:%d, frame: %@", __PRETTY_FUNCTION__, __LINE__, NSStringFromCGRect(view.frame));
    }
}

//MARK: - From selected value to slider value
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self updateSliderValue];
}

- (void)setNumberOfindexes:(NSUInteger)numberOfindexes {
    _numberOfindexes = numberOfindexes;
    [self updateSliderValue];
}

- (void)updateSliderValue {
    if (self.numberOfindexes > 1) {
        self.slider.value = (float)self.selectedIndex/(float)(self.numberOfindexes - 1);
    }
}

//MARK: - From slider value to selected value

- (void)sliderChangedValue {
    float value = self.slider.value;
    
    if (self.numberOfindexes > 0) {
        NSUInteger oldValue = self.selectedIndex;
        self.selectedIndex = (int)(value * self.numberOfindexes);
        
        if (self.selectedIndex != oldValue)
            [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}


- (float)relativeYForIndex:(NSUInteger)index {
    
    if (self.numberOfindexes < 2) {
        return 0;
    }
    
    float value = (float)index / (float)(self.numberOfindexes - 1);
    return [self relativeYForValue:value];
}


- (float)relativeYForValue:(float)value {
    float H = self.frame.size.height;
    float h = 30.0;
    
    return (H - h) * value + h/2;
}

@end
