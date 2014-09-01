//
//  SVMViewController.m
//  SVMDropDown
//
//  Created by staticVoidMan on 01/09/14.
//  Copyright (c) 2014 svmLogics. All rights reserved.
//

#import "SVMViewController.h"
#import "SVMDropDown.h"

@interface SVMViewController ()

@end

@implementation SVMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SVMDropDown *dropDown = [[SVMDropDown alloc] initWithNibName:@"SVMDropDown" bundle:nil];
    
    [self addChildViewController:dropDown];
    [self.view addSubview:dropDown.view];
    [dropDown didMoveToParentViewController:self];
    [dropDown.view setFrame:CGRectMake(0, 20, 320, 64)];
}

@end
