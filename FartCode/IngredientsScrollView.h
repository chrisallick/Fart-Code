//
//  PickBattleScrollView.h
//  DaliMuseumStaringApp
//
//  Created by chrisallick on 12/17/13.
//  Copyright (c) 2013 gspsf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IngredientsScrollView.h"
#import "IngredientView.h"

#import "AFNetworking.h"

@protocol IngredientsScrollViewDelegate

-(void) launchDescriptionViewWithTitle:(NSString *)title andCopy:(NSString *)copy;

@end

@interface IngredientsScrollView : UIScrollView {
    int lastHeight;

    __weak id <IngredientsScrollViewDelegate> isvd;
}

@property (nonatomic, weak) id <IngredientsScrollViewDelegate> isvd;

-(void) loadIngredients:(NSMutableArray *)ingredients;

@end
