//
//  ViewController.h
//  ImageFilter
//
//  Created by CHIEN NGUYEN on 3/14/14.
//  Copyright (c) 2014 CHIEN NGUYEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)filterImage:(UISlider *)sender;


@end
