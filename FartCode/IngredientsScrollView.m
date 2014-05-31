//
//  PickBattleScrollView.m
//  DaliMuseumStaringApp
//
//  Created by chrisallick on 12/17/13.
//  Copyright (c) 2013 gspsf. All rights reserved.
//

#import "IngredientsScrollView.h"

@implementation IngredientsScrollView

@synthesize isvd;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }

    return self;
}

-(void) loadIngredients:(NSMutableArray *)ingredients {
    lastHeight = 0;
    
    for( int i = 0; i < [ingredients count]; i++) {
        IngredientView *iv;
        iv = [[IngredientView alloc] initWithFrame:CGRectMake(0.0, lastHeight, self.frame.size.width, 0.0) andIngredient:[ingredients objectAtIndex:i]];
        [iv setUserInteractionEnabled:TRUE];
        [iv setTag:(i+1)];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [tapGesture setNumberOfTapsRequired:1];
        [iv addGestureRecognizer:tapGesture];
        
        [self addSubview:iv];
        
        lastHeight += iv.frame.size.height;
    }
    
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in self.subviews) {
        scrollViewHeight += view.frame.size.height;
    }
    
    [self setBounces:NO];
    [self setContentSize:(CGSizeMake(self.frame.size.width, scrollViewHeight))];
}

//- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
//    return ![view isKindOfClass:[UIButton class]];
//}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    IngredientView *view = (UIView *)sender.view;
    [UIView animateWithDuration: 0.150
                          delay: 0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{
                         [view setTransform:CGAffineTransformMakeScale(0.85, 0.85)];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration: 0.150
                                               delay: 0.0
                                             options: UIViewAnimationCurveEaseInOut
                                          animations:^{
                                              [view setTransform:CGAffineTransformIdentity];
                                          }
                                          completion:^(BOOL finished) {
                                              NSString *ingredient = [view.ingredientLabel text];
                                              if( [ingredient isEqualToString:@"fructose"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Fructose—a natural sugar found in plants such as onions, corn, wheat and even pears. Farty."]];
                                              } else if( [ingredient isEqualToString:@"raffinose"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Raffinose—the secret gas-inducing ingredient in beans. Also found in broccoli, cauliflower, cabbage, asparagus and other vegetables. You can take stuff like Beano to break raffinose down so you won’t be rippin’ ’em so big time."]];
                                              } else if( [ingredient isEqualToString:@"carbinat"] || [ingredient isEqualToString:@"carbonation"] || [ingredient isEqualToString:@"carbinated"] || [ingredient isEqualToString:@"sparkling water"] || [ingredient isEqualToString:@"sparkling mineral water"]) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Carbonated beverages like soda have a flatulence-inducing effect: when you put gas inside your body, it has to escape somewhere, either by burp or sweet buns’ music."]];
                                              } else if( [ingredient isEqualToString:@"sugar"] || [ingredient isEqualToString:@"high-fructose"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"A common sweetener that sneaks its way into all kinds of processed foods. Since it contains high levels of fructose, it can make you fart."]];
                                              } else if( [ingredient isEqualToString:@"lactose"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Lactose-this is milk's secret fart power. Also added to foods like bread and cereal. Some people have low levels of lactase, the enzyme that breaks down lactose; this makes them even fartier."]];
                                              } else if( [ingredient isEqualToString:@"sorbitol"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Sorbitol, found naturally in fruits, is also a common artificial sweetener in chewing gum and other sugar-free foods. It’s hard to digest, making it low calorie, but that also means it makes your butt erupt."]];
                                              } else if( [ingredient isEqualToString:@"wheat"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Fiber-rich foods are part of a healthy diet, but also contain indigestible carbohydrates that make you fart. If you want to increase the amount of fiber in your diet, do it slowly to give your system a chance to adjust, or else you’ll be performing many a wind symphony."]];
                                              } else if( [ingredient isEqualToString:@"beans"] || [ingredient isEqualToString:@"bean"] ) {
                                                  [isvd launchDescriptionViewWithTitle:@"beans" andCopy:[NSString stringWithFormat:@"Beans-the musical fruit. The more you eat, the more you toot. Which is awesome. All because of a sugar called raffinose (nose!). You can make them less gas inducing by soaking them overnight, draining them and then cooking them in fresh water. But why?"]];
                                              } else if( [ingredient isEqualToString:@"whey"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Whey is a protein that can be tough for your body to break down and digest. For some people, gas and bloating is the result. And we all know what sound gas and bloating makes."]];
                                              } else if( [ingredient isEqualToString:@"dairy"] || [ingredient isEqualToString:@"milk"] || [ingredient isEqualToString:@"butter"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Dairy products such as milk and have lactose, which can be a challenge for most people’s pipes to break down. The result? KABOOM. Of the trousers."]];
                                              } else if( [ingredient isEqualToString:@"fiber"] ) {
                                                  [isvd launchDescriptionViewWithTitle:ingredient andCopy:[NSString stringWithFormat:@"Eat more fiber. You've probably heard it before. Fiber is known to prevent and relieve constipation. Which means it \"gets things moving.\" And sometimes \"things\" are farts."]];
                                              }
                                          }];
                     }];
}

@end
