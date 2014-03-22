//
//  Imagefilter_CIToneCurveViewController.m
//  ImageFilter
//
//  Created by CHIEN NGUYEN on 3/21/14.
//  Copyright (c) 2014 CHIEN NGUYEN. All rights reserved.
//

#import "Imagefilter_CIToneCurveViewController.h"

@interface Imagefilter_CIToneCurveViewController ()

@end

@implementation Imagefilter_CIToneCurveViewController
{
    CIContext *context;
    CIFilter *filter;
    CIImage *beginImage;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"none" ofType:@"jpg"]];
    beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    
    //setup CIContext object
    context = [CIContext contextWithOptions:nil];
    
    //tonecurve filter
    filter = [CIFilter filterWithName:@"CIToneCurve"];
    [filter setDefaults];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    
    [filter setValue:[CIVector vectorWithX:0.0  Y:0.1] forKey:@"inputPoint0"]; // default
    
    [filter setValue:[CIVector vectorWithX:0.2 Y:0.5] forKey:@"inputPoint1"];
    [filter setValue:[CIVector vectorWithX:0.5  Y:0.1] forKey:@"inputPoint2"];
    [filter setValue:[CIVector vectorWithX:0.8  Y:0.5] forKey:@"inputPoint3"];
    [filter setValue:[CIVector vectorWithX:1.0  Y:1.0] forKey:@"inputPoint4"];

    
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    
    self.imageView.image = newImage;
    
    //free data
    CGImageRelease(cgimg);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
