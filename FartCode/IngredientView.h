//
//  PickBattleView.h
//  DaliMuseumStaringApp
//
//  Created by chrisallick on 12/30/13.
//  Copyright (c) 2013 gspsf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+AFNetworking.h"
#import "THLabel.h"

@interface IngredientView : UIView {
    THLabel *ingredientLabel;
}

- (id)initWithFrame:(CGRect)frame andIngredient:(NSString *)ingredient;

@property (nonatomic, retain) THLabel *ingredientLabel;

@end
