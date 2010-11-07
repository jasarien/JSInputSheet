//
//  JSInputSheet.h
//  JSInputSheet
//
//  Created by James on 07/11/2010.
//  Copyright 2010 JamSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSInputSheet;

@protocol JSInputSheetDelegate <NSObject>

- (void)inputSheetDidDismiss:(JSInputSheet *)inputSheet;
- (void)inputSheetDidCancel:(JSInputSheet *)inputSheet;

@end


@interface JSInputSheet : UIView <UITextFieldDelegate> {

	UILabel *_titleLabel;
	UITextField *_textField1;
	UITextField *_textField2;
	
	UIView *_dimmingView;
	
	id <JSInputSheetDelegate> _delegate;

}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextField *textField1;
@property (nonatomic, retain) UITextField *textField2;
@property (nonatomic, assign) id <JSInputSheetDelegate> delegate;

- (id)initWithTitle:(NSString *)title delegate:(id <JSInputSheetDelegate>)delegate;

- (void)show;

@end
