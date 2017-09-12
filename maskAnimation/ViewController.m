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

- (void)animateMask:(CAShapeLayer *)mask  forImageView:(UIImageView *)image{
	
	// https://stackoverflow.com/questions/11391058/simply-mask-a-uiview-with-a-rectangle
	
	
	if(image == nil){
		return;
	}
	
	mask = [[CAShapeLayer alloc] init];
	
	// Create a path with the rectangle in it.
	CGRect maskRect = CGRectMake(0, 0, 100, 100);
	CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
	
	
	mask.path = path;
	CGPathRelease(path);
	
	image.layer.mask = mask;
	image.layer.masksToBounds = YES;
	

	
}

@end
