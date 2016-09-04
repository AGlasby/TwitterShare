//
//  ViewController.m
//  TwitterShare
//
//  Created by Alan Glasby on 01/09/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

#import "ViewController.h"
#import "social/social.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextFld;

- (void) configureTweetTextView;
- (void) showAlertMessage:(NSString *) myMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTweetTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showAlertMessage:(NSString *) myMessage{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"TwitterShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated: YES completion:nil];

}

- (IBAction)showShareAction:(id)sender {
    if ([self.tweetTextFld isFirstResponder]) {
        [self.tweetTextFld resignFirstResponder];
    }

    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Test title" message:@"alert test message" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [actionController addAction:cancelAction];

    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDefault handler:
                                  ^(UIAlertAction *action) {
                                      if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                                          SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                          if([self.tweetTextFld.text length] < 140) {
                                              [twitterVC setInitialText:self.tweetTextFld.text];
                                          } else {
                                              NSString *tweetCompliantText = [self.tweetTextFld.text substringToIndex:140];
                                              [twitterVC setInitialText:tweetCompliantText];
                                          }
                                          [self presentViewController:twitterVC animated:YES completion:nil];

                                      } else {
                                          [self showAlertMessage:@"Please log in to twitter before you try to tweet"];
                                      }
                                  }];
    [actionController addAction:tweetAction];    [self presentViewController:actionController animated:YES completion:nil];
}

- (void) configureTweetTextView {
    self.tweetTextFld.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweetTextFld.layer.cornerRadius = 10;
    self.tweetTextFld.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextFld.layer.borderWidth = 2.0;

}

@end
