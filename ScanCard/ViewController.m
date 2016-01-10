//
//  ViewController.m
//  ScanCard
//
//  Created by Mohit Sadhu on 1/10/16.
//  Copyright © 2016 Mohit Sadhu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cardInfoLabel;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _cardView = [[CardIOView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    if ( ![CardIOUtilities canReadCardWithCamera])
    {
        //hide the card scan button
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [CardIOUtilities preload];
}

- (IBAction)scanCard:(id)sender
{
    
    UIView *overlayCancelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 200, 50)];
    
    [cancelButton addTarget:self action:@selector(cancelScanCard:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor yellowColor];
    [overlayCancelView addSubview:cancelButton];
    
    _cardView.delegate = self;
    _cardView.hideCardIOLogo = TRUE;
    _cardView.scanOverlayView = overlayCancelView;
    
    [self.view addSubview:_cardView];
}

- (void)cancelScanCard: (CardIOView *)cardview
{
    NSLog(@"cancel card button tapped");
    [self.cardView removeFromSuperview];
}



#pragma mark - CardIOView delegates

- (void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)cardInfo
{
    if (cardInfo)
    {
        NSLog(@"received card info. \nNumber : %@ \nExpiry : %02lu/%lu \n CVV : %@ \n Card Type; %ld", cardInfo.cardNumber, (unsigned long)cardInfo.expiryMonth, (unsigned long)cardInfo.expiryYear, cardInfo.cvv, (long)cardInfo.cardType);
        
        NSLog(@"Card Type: %@", [CardIOCreditCardInfo displayStringForCardType:cardInfo.cardType usingLanguageOrLocale:@"en"]);
        NSString *cardTypeStr = [CardIOCreditCardInfo displayStringForCardType:cardInfo.cardType usingLanguageOrLocale:@"en"];
        
        self.cardInfoLabel.text = [NSString stringWithFormat:@"received card info. \nNumber : %@ \nExpiry : %02lu/%lu \n CVV : %@ \n Card Type; %@", cardInfo.cardNumber, (unsigned long)cardInfo.expiryMonth, (unsigned long)cardInfo.expiryYear, cardInfo.cvv, cardTypeStr];
    }
    else
    {
        NSLog(@"User cancelled scan.");
    }
    
    [cardIOView removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
