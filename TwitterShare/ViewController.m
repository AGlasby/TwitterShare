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
@property (weak, nonatomic) IBOutlet UITextView *facebookTextFld;
@property (weak, nonatomic) IBOutlet UITextView *moreTextFld;

- (void) configureTweetTextView;
- (void) showAlertMessage:(NSString *) myMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTweetTextView];
    [self configureFacebookTextView];
    [self configureMoreTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showAlertMessage:(NSString *) myMessage{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"ShareIT" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated: YES completion:nil];

}


- (IBAction)showTweetAction:(id)sender {
    if ([self.tweetTextFld isFirstResponder]) {
        [self.tweetTextFld resignFirstResponder];
    }

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
}

- (IBAction)showFacebookAction:(id)sender {
    if ([self.facebookTextFld isFirstResponder]) {
        [self.facebookTextFld resignFirstResponder];
    }

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookVC setInitialText:self.facebookTextFld.text];
        [self presentViewController:facebookVC animated:YES completion:nil];
    } else {
        [self showAlertMessage:@"Please log in to facebook before you try to share"];
    }
}

- (IBAction)showMoreAction:(id)sender {
    if ([self.moreTextFld isFirstResponder]) {
        [self.moreTextFld resignFirstResponder];
    }

    UIActivityViewController *moreVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.moreTextFld.text] applicationActivities:nil];
    [self presentViewController:moreVC animated:YES completion:nil];
}

- (IBAction)showNothingAction:(id)sender {
    if ([self.tweetTextFld isFirstResponder]) {
        [self.tweetTextFld resignFirstResponder];
    }

    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Alert Controller Message" message:@"This option currently does nothing other than display this message." preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];

    [actionController addAction:cancelAction];
    [self presentViewController:actionController animated:YES completion:nil];
}

- (void) configureTweetTextView {
    self.tweetTextFld.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweetTextFld.layer.cornerRadius = 8;
    self.tweetTextFld.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextFld.layer.borderWidth = 2.0;

}

- (void) configureFacebookTextView {
    self.facebookTextFld.layer.backgroundColor = [UIColor colorWithRed:0.9 green:1.0 blue:1.0 alpha:1.0].CGColor;
    self.facebookTextFld.layer.cornerRadius = 8;
    self.facebookTextFld.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.facebookTextFld.layer.borderWidth = 2.0;

}

- (void) configureMoreTextView {
    self.moreTextFld.layer.backgroundColor = [UIColor colorWithRed:1.0 green:0.9 blue:1.0 alpha:1.0].CGColor;
    self.moreTextFld.layer.cornerRadius = 8;
    self.moreTextFld.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.moreTextFld.layer.borderWidth = 2.0;

}

@end








