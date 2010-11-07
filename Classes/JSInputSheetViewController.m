//
//  JSInputSheetViewController.m
//  JSInputSheet
//
//  Created by James on 07/11/2010.
//  Copyright 2010 JamSoft. All rights reserved.
//

#import "JSInputSheetViewController.h"
#import "JSInputSheet.h"

@implementation JSInputSheetViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad
{
	[super viewDidLoad];
	//[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (IBAction)showInputView
{
	JSInputSheet *inputSheet = [[[JSInputSheet alloc] initWithTitle:@"Login" delegate:self] autorelease];
	[inputSheet.textField1 setPlaceholder:@"Username"];
	[inputSheet.textField2 setPlaceholder:@"Password"];
	[inputSheet.textField2 setSecureTextEntry:YES];
	[inputSheet show];
}

- (void)inputSheetDidDismiss:(JSInputSheet *)inputSheet
{
	NSLog(@"Sheet did dismiss, textfield 1: %@, textfield 2: %@", [inputSheet.textField1 text], [inputSheet.textField2 text]);
}

- (void)inputSheetDidCancel:(JSInputSheet *)inputSheet
{
	NSLog(@"sheet did cancel");
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
