//
//  OFHomeViewController.m
//  OrangeFashion
//
//  Created by Khang on 9/6/13.
//  Copyright (c) 2013 Khang. All rights reserved.
//

#import "OFHomeViewController.h"

@interface OFHomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lbViewProducts;

@end

@implementation OFHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fake home"]];
    bgImage.contentMode = UIViewContentModeScaleAspectFill;
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    bgImage.frame = frame;
    
    [self.view addSubview:bgImage];
    
    [self.view bringSubviewToFront:self.lbViewProducts];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showProductsList)];
    
    tapGesture.numberOfTapsRequired = 1;
    
    [self.lbViewProducts addGestureRecognizer:tapGesture];
}

- (void)showProductsList
{
    [self performSegueWithIdentifier:@"From Home To Products List" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLbViewProducts:nil];
    [super viewDidUnload];
}
@end