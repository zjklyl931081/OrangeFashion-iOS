//
//  OFProductDetailsViewController.m
//  OrangeFashion
//
//  Created by Khang on 1/6/13.
//  Copyright (c) 2013 Khang. All rights reserved.
//

#import "OFProductDetailsViewController.h"
#import "OFImageViewController.h"
#import "OFProductImages.h"
#import "OFProduct.h"

@interface OFProductDetailsViewController ()

@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) UIPageViewController *pageVC;
@property (assign, nonatomic) int currentVC;

@end

@implementation OFProductDetailsViewController

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
    
    OFProduct *product = [OFProduct productWithDictionary:@{ @"MaSanPham" : self.productID}];
    
    __block NSMutableArray *arrVC = [[NSMutableArray alloc] init];
    
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    __weak OFProductDetailsViewController *weakSelf = self;
    
    [OFProductImages getImagesForProduct:product successBlock:^(NSInteger statusCode, id obj) {
        weakSelf.images = obj;
        weakSelf.currentVC = 0;
//        [obj enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx, BOOL *stop) {
            OFImageViewController *imageVC = [[OFImageViewController alloc] init];
            imageVC.imageURL = [[obj objectAtIndex:0] picasa_store_source];
            DLog(@"imgURL = %@", [[obj objectAtIndex:0] picasa_store_source]);
            [arrVC addObject:imageVC];
//        }];
        
        DLog(@"Array ImagesVC = %@", [arrVC description]);
        
        [self.pageVC setViewControllers:[NSArray arrayWithObject:imageVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        
        [self addChildViewController:self.pageVC];
        [self.view addSubview:self.pageVC.view];
        [self.pageVC didMoveToParentViewController:self];
        
        CGRect pageViewRect = self.view.frame;
        pageViewRect = CGRectInset(pageViewRect, 0, 0);
        self.pageVC.view.frame = pageViewRect;
        
        self.view.gestureRecognizers = self.pageVC.gestureRecognizers;
        
    } failureBlock:^(NSInteger statusCode, id obj2) {
        //handle errors
    }];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    OFImageViewController *imageVC = [[OFImageViewController alloc] init];
    imageVC.imageURL = [[self.images objectAtIndex:self.currentVC+1] picasa_store_source];
    return imageVC;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    OFImageViewController *imageVC = [[OFImageViewController alloc] init];
    imageVC.imageURL = [[self.images objectAtIndex:self.currentVC-1] picasa_store_source];
    return imageVC;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.images.count;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
