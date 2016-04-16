//
//  WebViewController.m
//  6WebView
//
//  Created by Alejandro Gomez on 19/12/13.
//  Copyright (c) 2013 Intergrupo. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (nonatomic, strong) NSString *currentURL;

@end

@implementation WebViewController


#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.currentURL = @"http://www.google.com";
    [self validateButtons];
    [self loadWebViewByRequest];
}

- (void)loadWebViewByRequest
{
    self.textField.text = self.currentURL;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.currentURL]];
    [self.webView loadRequest:request];
}


#pragma mark - UIWebView

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.stopButton.enabled = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self validateButtons];
    self.stopButton.enabled = NO;
    self.textField.text = self.webView.request.URL.absoluteString;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];*/
}


#pragma mark - UITextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.currentURL = [NSString stringWithFormat:@"http://%@", [textField.text stringByReplacingOccurrencesOfString:@"http://" withString:@""]];
    [self.textField resignFirstResponder];
    [self loadWebViewByRequest];
    return YES;
}


#pragma mark - UIBarButton

- (void)validateButtons
{
    if ([self.webView canGoBack])
        self.backButton.enabled = YES;
    else
        self.backButton.enabled = NO;
    if ([self.webView canGoForward])
        self.forwardButton.enabled = YES;
    else
        self.forwardButton.enabled = NO;
}

- (IBAction)goBack:(id)sender
{
    if ([self.webView canGoBack])
        [self.webView goBack];
}

- (IBAction)goForward:(id)sender
{
    if ([self.webView canGoForward])
        [self.webView goForward];
}

- (IBAction)refresh:(id)sender
{
    [self.webView reload];
}

- (IBAction)stopLoading:(id)sender
{
    [self.webView stopLoading];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
