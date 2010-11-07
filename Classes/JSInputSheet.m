//
//  JSInputSheet.m
//  JSInputSheet
//
//  Created by James on 07/11/2010.
//  Copyright 2010 JamSoft. All rights reserved.
//

#import "JSInputSheet.h"
#import <QuartzCore/QuartzCore.h>

@interface JSInputSheet ()

- (void)done:(id)sender;
- (void)cancel:(id)sender;

- (void)showDimmingView;
- (void)showInputView;

- (void)hideInputView;
- (void)hideDimmingView;

- (void)dismiss;
- (void)removeViews;

@end


@implementation JSInputSheet

@synthesize titleLabel = _titleLabel;
@synthesize textField1 = _textField1;
@synthesize textField2 = _textField2;
@synthesize delegate = _delegate;

- (id)initWithTitle:(NSString *)title delegate:(id <JSInputSheetDelegate>)delegate
{
	if ((self = [super initWithFrame:CGRectMake(0, 0, 320, 139)]))
	{
		UIView *background = [[[UIView alloc] initWithFrame:[self frame]] autorelease];
		[background setBackgroundColor:[UIColor blackColor]];
		[background setAlpha:0.6];
		[background.layer setCornerRadius:5.0];
		[background.layer setShadowOffset:CGSizeMake(0, 4)];
		[background.layer setShadowOpacity:0.7];
		[self addSubview:background];
		
		self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 14, 280, 21)] autorelease];
		[self.titleLabel setText:title];
		[self.titleLabel setTextColor:[UIColor whiteColor]];
		[self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
		[self.titleLabel setShadowColor:[UIColor blackColor]];
		[self.titleLabel setShadowOffset:CGSizeMake(0, -1)];
		[self.titleLabel setTextAlignment:UITextAlignmentCenter];
		[self.titleLabel setBackgroundColor:[UIColor clearColor]];
		[self.titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		[self.titleLabel setOpaque:NO];
		
		[self addSubview:self.titleLabel];
		
		self.textField1 = [[[UITextField alloc] initWithFrame:CGRectMake(20, 49, 280, 31)] autorelease];
		[self.textField1 setBorderStyle:UITextBorderStyleRoundedRect];
		[self.textField1 setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		[self.textField1 setDelegate:self];
		[self.textField1 setKeyboardAppearance:UIKeyboardAppearanceAlert];
		[self.textField1 setReturnKeyType:UIReturnKeyDone];
		
		[self addSubview:self.textField1];
		
		self.textField2 = [[[UITextField alloc] initWithFrame:CGRectMake(20, 88, 280, 31)] autorelease];
		[self.textField2 setBorderStyle:UITextBorderStyleRoundedRect];
		[self.textField2 setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
		[self.textField2 setDelegate:self];
		[self.textField2 setKeyboardAppearance:UIKeyboardAppearanceAlert];
		[self.textField2 setReturnKeyType:UIReturnKeyDone];
		
		[self addSubview:self.textField2];
		
		UIToolbar *toolbar = [[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
		[toolbar setBarStyle:UIBarStyleBlackTranslucent];
		
		UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																					 target:self
																					 action:@selector(done:)] autorelease];
		UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																					   target:self
																					   action:@selector(cancel:)] autorelease];
		UIBarButtonItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				target:nil action:nil] autorelease];
		[toolbar setItems:[NSArray arrayWithObjects:cancelButton, space, doneButton, nil]];
		
		[self.textField1 setInputAccessoryView:toolbar];
		[self.textField2 setInputAccessoryView:toolbar];
		
		self.delegate = delegate;
		
	}
	
	return self;
}

- (void)dealloc
{
	self.titleLabel = nil;
	self.textField1 = nil;
	self.textField2 = nil;
	self.delegate = nil;
	_dimmingView = nil;
	
	[super dealloc];
}

- (void)show
{
	[self showDimmingView];
	[self showInputView];
}

- (void)showDimmingView
{
	UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
	_dimmingView = [[[UIView alloc] initWithFrame:[keyWindow frame]] autorelease];
	[_dimmingView setBackgroundColor:[UIColor blackColor]];
	[_dimmingView setAlpha:0.0];
	[keyWindow addSubview:_dimmingView];
	
	[UIView beginAnimations:nil context:nil];
	
	[_dimmingView setAlpha:0.4];
	
	[UIView commitAnimations];
}

- (void)showInputView
{
	CGFloat yPos = 0;
	
	CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
	if (CGRectIsEmpty(statusBarFrame))
	{
		yPos = -5;
	}
	else
	{
		yPos = 15;
	}
	
	UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
	
	CGRect aFrame = [self frame];
	aFrame.origin = CGPointMake(0, aFrame.origin.y - aFrame.size.height);
	[self setFrame:aFrame];
	[keyWindow addSubview:self];
	
	[UIView beginAnimations:nil context:nil];
	
	aFrame.origin.y = yPos;
	[self setFrame:aFrame];
	
	[UIView commitAnimations];
	
	[self.textField1 becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([self.delegate respondsToSelector:@selector(inputSheetDidDismiss:)])
	{
		[self.delegate inputSheetDidDismiss:self];
	}
	
	[self dismiss];
	
	return YES;
}

- (void)done:(id)sender
{
	if ([self.delegate respondsToSelector:@selector(inputSheetDidDismiss:)])
	{
		[self.delegate inputSheetDidDismiss:self];
	}
	
	[self dismiss];
}

- (void)cancel:(id)sender
{
	if ([self.delegate respondsToSelector:@selector(inputSheetDidCancel:)])
	{
		[self.delegate inputSheetDidCancel:self];
	}
	
	[self dismiss];
}

- (void)dismiss
{
	[self.textField1 resignFirstResponder];
	[self.textField2 resignFirstResponder];
	[self hideInputView];
}

- (void)hideInputView
{
	CGRect aFrame = [self frame];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(hideDimmingView)];
	
	aFrame.origin.y = 0 - aFrame.size.height;
	[self setFrame:aFrame];
	
	[UIView commitAnimations];
}

- (void)hideDimmingView
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(removeViews)];
	
	[_dimmingView setAlpha:0.0];
	
	[UIView commitAnimations];
}

- (void)removeViews
{
	[_dimmingView removeFromSuperview];
	[self removeFromSuperview];
}

@end
