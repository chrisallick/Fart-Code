//
//  PickBattleView.m
//  DaliMuseumStaringApp
//
//  Created by chrisallick on 12/30/13.
//  Copyright (c) 2013 gspsf. All rights reserved.
//

#import "IngredientView.h"

@implementation IngredientView

@synthesize ingredientLabel;

- (id)initWithFrame:(CGRect)frame andIngredient:(NSString *)ingredient {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *bgImage = [UIImage imageNamed:@"ingredientBackground.png"];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, bgImage.size.width/2.0, bgImage.size.height/2.0)];
        [bg setImage:bgImage];
        [self addSubview:bg];

        ingredientLabel = [[THLabel alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, 34.0)];
        [ingredientLabel setTextAlignment:NSTextAlignmentCenter];
        [ingredientLabel setNumberOfLines:0];
        [ingredientLabel setFont:[UIFont fontWithName:@"DCC-Cloud" size:34.0]];
        [ingredientLabel setTextColor:[UIColor colorWithRed:0.992 green:0.529 blue:0.639 alpha:1]];
        [ingredientLabel setStrokeColor:[UIColor blackColor]];
        [ingredientLabel setStrokeSize:2.0];
        
        if( [ingredient isEqualToString:@"carbonat"] || [ingredient isEqualToString:@"sparkling water"] ) {
            [ingredientLabel setText:@"carbonation"];
        } else if( [ingredient isEqualToString:@"bean"] ) {
            [ingredientLabel setText:@"beans"];
        } else {
            [ingredientLabel setText:ingredient];
        }

        [self addSubview:ingredientLabel];
        
        float h = 0;
        for (UIView *v in [self subviews]) {
            float fh = v.frame.origin.y + v.frame.size.height;
            h = MAX(fh, h);
        }

        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, frame.size.width, h+12.0)];
    }
    return self;
}

@end
