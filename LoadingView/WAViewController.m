//
//  WAViewController.m
//  LoadingView
//
//  Created by Rajiv Narayana Singaseni on 10/8/12.
//  Copyright (c) 2012 WebileApps. All rights reserved.
//

#import "WAViewController.h"

@interface WALoadingView : UIView {
    UIView *centerPanel;
    UIActivityIndicatorView *activityIndicatorView;
    UILabel *messageLabel;
}

- (void) setMessage:(NSString *) message;

@end

@implementation WALoadingView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customInit];
    }
    return self;
}

//create views.
- (void) customInit {
    self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2f];
    centerPanel = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:centerPanel];
    centerPanel.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.64f];
    centerPanel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectOffset(activityIndicatorView.frame, 20, 0);
    activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    [activityIndicatorView startAnimating];
    [centerPanel addSubview:activityIndicatorView];
    
    messageLabel = [[UILabel alloc] initWithFrame:CGRectOffset(centerPanel.bounds, 75, 0)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = [UIFont systemFontOfSize:20.f];
    messageLabel.text = @"Loading...";
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [centerPanel addSubview:messageLabel];
    
//    [centerPanel.layer setCornerRadius:10.0];
//    [centerPanel.layer setBorderColor:[UIColor whiteColor].CGColor];
//    [centerPanel.layer setBorderWidth:5.0];
    
}

- (void) layoutSubviews {
    [super layoutSubviews];
    CGSize messageLabelSize = [messageLabel sizeThatFits:self.bounds.size];
    CGRect centerPanelFrame = CGRectInset(CGRectMake(0, 0, messageLabelSize.width, messageLabelSize.height), -50.f, -50.f);
    centerPanel.frame = CGRectMake(self.bounds.size.width/2 - centerPanelFrame.size.width/2, self.bounds.size.height/2 - centerPanelFrame.size.height/2, centerPanelFrame.size.width, centerPanelFrame.size.height);
}

- (void) setMessage:(NSString *)message {
    messageLabel.text = message;
    [self setNeedsDisplay];
}
@end

@interface WAViewController () {
    WALoadingView *loadingView;
}

@end

@implementation WAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) showLoadingView:(BOOL) show withMessage:(NSString *) message {
    //create a loading view if one not present.
    if (loadingView == nil) {
        loadingView = [[WALoadingView alloc] initWithFrame:self.view.bounds];
        loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:loadingView];
    }
    [loadingView setMessage:message];
    loadingView.hidden = !show;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showLoadingView:YES withMessage:@"Please wait while loading..."];
}

@end
