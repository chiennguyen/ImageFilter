//
//  ViewController.m
//  ImageFilter
//
//  Created by CHIEN NGUYEN on 3/14/14.
//  Copyright (c) 2014 CHIEN NGUYEN. All rights reserved.
//

#import <dispatch/dispatch.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CIContext *context;
    CIFilter *filter;
    CIImage *beginImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"image" ofType:@"jpg"]];
    beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    
    //setup CIContext object
    context = [CIContext contextWithOptions:nil];
    
    //sepiaTone filter
    filter = [CIFilter filterWithName:@"CISepiaTone"];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    
    //display original image
    self.imageView.image = [UIImage imageWithCIImage:beginImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)filterImage:(UISlider *)sender {

    
    float sliderValue = sender.value;
    
    
    //run the image filter in background queue to prevent "choppy slider"
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.samplequeue", NULL);
    dispatch_queue_t main = dispatch_get_main_queue();
    
    dispatch_async(backgroundQueue, ^{
        [filter setValue:@(sliderValue) forKey:kCIInputIntensityKey];
        CIImage *outputImage = [filter outputImage];
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *newImage = [UIImage imageWithCGImage:cgimg];
        
        dispatch_async(main, ^{
            self.imageView.image = newImage;
            
            //Free data
            CGImageRelease(cgimg);
        });
    });
    
    
}
@end
