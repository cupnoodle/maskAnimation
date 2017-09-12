//
//  ViewController.m
//  maskAnimation
//
//  Created by Axel Kee on 12/09/2017.
//  Copyright © 2017 Sweatshop. All rights reserved.
//


#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()



@end

@implementation ViewController

CAShapeLayer *maskLayer;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)animateTapped:(id)sender {
	[self animateMask:maskLayer forImageView:self.tailsImage];
}

- (IBAction)stopTapped:(id)sender {
	[self.tailsImage.layer.mask removeAllAnimations];
}

- (void)animateMask:(CAShapeLayer *)mask  forImageView:(UIImageView *)image{
	
	// https://stackoverflow.com/questions/11391058/simply-mask-a-uiview-with-a-rectangle
	// https://stackoverflow.com/questions/1166721/what-does-fillmode-do-exactly
	// https://stackoverflow.com/questions/554997/cancel-a-uiview-animation
	
	if(image == nil){
		return;
	}
	
	mask = [[CAShapeLayer alloc] init];
	
	// Create a path with the rectangle in it.
	CGRect maskRect = CGRectMake(0, 0, 1, image.frame.size.height);

	UIBezierPath *startPath = [UIBezierPath bezierPathWithRect:maskRect];
	
	mask.path = startPath.CGPath;
	
	image.layer.mask = mask;
//	image.layer.masksToBounds = YES;
	
	// Create the middle path
	CGRect middleRect = CGRectMake(0, 0, image.frame.size.width, image.frame.size.height);
	UIBezierPath *middlePath = [UIBezierPath bezierPathWithRect:middleRect];
	
	// key path must put "path" to animate the path property
	CABasicAnimation *leftToRightAnim = [CABasicAnimation animationWithKeyPath:@"path"];
	leftToRightAnim.fromValue = (id)startPath.CGPath;
	leftToRightAnim.toValue = (id)middlePath.CGPath;
	leftToRightAnim.beginTime = 0.0;
	leftToRightAnim.duration = 1.0;
	leftToRightAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//	leftToRightAnim.fillMode = kCAFillModeForwards;
	
	// Create the end path
	CGRect endRect =CGRectMake(image.frame.size.width - 1.0, 0, 1.0, image.frame.size.height);
	
	UIBezierPath *endPath = [UIBezierPath bezierPathWithRect:endRect];
	
	CABasicAnimation *leftToRightAnim2 = [CABasicAnimation animationWithKeyPath:@"path"];
	leftToRightAnim2.fromValue = (id)middlePath.CGPath;
	leftToRightAnim2.toValue = (id)endPath.CGPath;
	leftToRightAnim2.beginTime = 1.5;
	leftToRightAnim2.duration = 1.0;
	leftToRightAnim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

	CAAnimationGroup *leftToRightAnimGroup = [[CAAnimationGroup alloc] init];
	leftToRightAnimGroup.animations = @[leftToRightAnim, leftToRightAnim2 ];
	leftToRightAnimGroup.duration = 2.5;
	leftToRightAnimGroup.repeatCount = HUGE_VALF;
//	leftToRightAnim2.fillMode = kCAFillModeForwards;
	
	
	[mask addAnimation:leftToRightAnimGroup forKey:@"animatePath"];
	
	// assign path after animation ends
	mask.path = middlePath.CGPath;
}

@end
