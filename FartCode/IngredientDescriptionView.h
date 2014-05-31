//
//  IngredientDescriptionView.h
//  Fart Code
//
//  Created by chrisallick on 4/20/14.
//  Copyright (c) 2014 gspsf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THLabel.h"

@protocol IngredientsDescriptionViewDelegate

-(void) closeDescription;

@end

@interface IngredientDescriptionView : UIView {
    THLabel *title;
    UITextView *copy;

    __weak id <IngredientsDescriptionViewDelegate> idvd;
}

@property (nonatomic, weak) id <IngredientsDescriptionViewDelegate> idvd;

-(void)setTitle:(NSString *)title andCopy:(NSString *)copy;

@end
