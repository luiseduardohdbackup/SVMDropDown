//
//  SVMDropDown.m
//  SVMDropDown
//
//  Created by staticVoidMan on 01/09/14.
//  Copyright (c) 2014 svmLogics. All rights reserved.
//

#import "SVMDropDown.h"
#import "SVMDropDownCell.h"

@interface SVMDropDown () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tvDropDown;
    IBOutlet UIButton *btnDropDown;
    IBOutlet UITextField *txtFSelected;
    
    IBOutlet UIView *vwBarContainer;
    IBOutlet UIView *vwDropDownContainerMain;
    IBOutlet UIView *vwDropDownContainerInner;
    IBOutlet UIView *vwDropDownSpacerLeft;
    IBOutlet UIView *vwDropDownSpacerRight;
    IBOutlet UIView *vwDropDownSpacerBottom;
    
    NSInteger i_rowCount;
    CGFloat radius;
}
@end

@implementation SVMDropDown

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
    i_rowCount = 0;
    radius = 10.0f;
    
    [tvDropDown registerNib:[UINib nibWithNibName:@"SVMDropDownCell" bundle:nil] forCellReuseIdentifier:@"DropDownCell"];
    
    [vwDropDownContainerMain setAlpha:0.0f];
    [self modifyUI];
    [self modifyUI_DropDownSpacerLeft];
    [self modifyUI_DropDownSpacerRight];
    [self modifyUI_DropDownSpacerBottom];
}

-(void)modifyUI
{
    [vwBarContainer.layer setCornerRadius:radius];
    [vwBarContainer.layer setMasksToBounds:YES];
}

-(void)modifyUI_DropDownSpacerLeft
{
    CGRect rect = vwDropDownSpacerLeft.bounds;

    CGPoint point_1_Arc = CGPointMake(0, radius);
    CGPoint point_2_Line = CGPointMake(radius, 0);

    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:point_1_Arc
                    radius:radius
                startAngle:3*M_PI_2
                  endAngle:2*M_PI
                 clockwise:YES];
    [path addLineToPoint:point_2_Line];
    [path closePath];

    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setFrame:rect];
    [layer setPath:path.CGPath];

    [vwDropDownSpacerLeft.layer setMask:layer];
    [vwDropDownSpacerLeft.layer setMasksToBounds:YES];
    [vwDropDownSpacerLeft setAlpha:0.0f];
}

-(void)modifyUI_DropDownSpacerRight
{
    CGRect rect = vwDropDownSpacerRight.bounds;
    
    CGPoint point_1_Arc = CGPointMake(radius, radius);
    CGPoint point_2_Line = CGPointMake(0, 0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:point_1_Arc
                    radius:radius
                startAngle:3*M_PI_2
                  endAngle:M_PI
                 clockwise:NO];
    [path addLineToPoint:point_2_Line];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setFrame:rect];
    [layer setPath:path.CGPath];
    
    [vwDropDownSpacerRight.layer setMask:layer];
    [vwDropDownSpacerRight.layer setMasksToBounds:YES];
    [vwDropDownSpacerRight setAlpha:0.0f];
}

-(void)modifyUI_DropDownSpacerBottom
{
    CGRect rect = vwDropDownSpacerBottom.bounds;
    
    CGPoint point_1_Arc = CGPointMake(radius, 0);
    CGPoint point_2_Line = CGPointMake(rect.size.width - radius, rect.size.height);
    CGPoint point_3_Arc = CGPointMake(rect.size.width - radius, 0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:point_1_Arc
                    radius:radius
                startAngle:M_PI
                  endAngle:M_PI_2
                 clockwise:NO];
    [path addLineToPoint:point_2_Line];
    [path addArcWithCenter:point_3_Arc
                    radius:radius
                startAngle:M_PI_2
                  endAngle:2*M_PI
                 clockwise:NO];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setFrame:rect];
    [layer setPath:path.CGPath];
    
    [vwDropDownSpacerBottom.layer setMask:layer];
    [vwDropDownSpacerBottom.layer setMasksToBounds:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return i_rowCount;
}

-(IBAction)btnDropDownAct:(UIButton *)sender
{
    [sender setSelected:!sender.selected];
    
    CGFloat alpha;
    
    CGRect rect = self.view.frame;
    if (sender.selected) {
        i_rowCount = 20;
        
        alpha = 1.0f;
        rect.size.height = 200;
    }
    else {
        i_rowCount = 0;
        
        alpha = 0.0f;
        rect.size.height = 64;
    }
    
    [UIView animateWithDuration:0.26f
                     animations:^{
                         [vwDropDownContainerMain setAlpha:alpha];
                         [vwDropDownSpacerLeft setAlpha:alpha];
                         [vwDropDownSpacerRight setAlpha:alpha];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.26f
                                          animations:^{
                                              [self.view setFrame:rect];
                                              [self.view layoutIfNeeded];
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }];
                     }];
    [tvDropDown reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DropDownCell";
    SVMDropDownCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SVMDropDownCell" owner:nil options:nil][0];
    }
    
    [cell.lblTitle setText:[NSString stringWithFormat:@"Choice %d",(indexPath.row+1)]];
    
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVMDropDownCell *cell = (SVMDropDownCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [txtFSelected setText:cell.lblTitle.text];
}

@end
