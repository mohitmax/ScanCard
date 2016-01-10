//
//  ViewController.h
//  ScanCard
//
//  Created by Mohit Sadhu on 1/10/16.
//  Copyright © 2016 Mohit Sadhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CardIO.h>

@interface ViewController : UIViewController <CardIOViewDelegate>

@property (strong, nonatomic) CardIOView *cardView;

@end

