//
//  JWNavigationController.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/22/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import "JWNavigationController.h"

@implementation JWNavigationController

@synthesize navigationBar;
@synthesize contentView;
@synthesize slideMenuController;
@synthesize rootViewController=_rootViewController;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        
        CGRect masterRect = [[UIScreen mainScreen] bounds];
        
        CGRect contentFrame = CGRectMake(0.0, 44.0, masterRect.size.width, masterRect.size.height - 44.0);
        CGRect navBarFrame = CGRectMake(0.0, 0.0, masterRect.size.width, 44.0);
        
        self.view = [[[UIView alloc] initWithFrame:masterRect] autorelease];
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.view.backgroundColor = [UIColor magentaColor];
        
        self.contentView = [[[UIView alloc] initWithFrame:contentFrame] autorelease];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.contentView];
        
        self.navigationBar = [[[UINavigationBar alloc] initWithFrame:navBarFrame] autorelease];
        self.navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        //[self.navigationBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"SlideMenu"] animated:NO];
        //UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon_20x20.png"] style:UIBarButtonItemStyleBordered target:self.slideMenuController action:@selector(toggleMenu)];
        [self.view insertSubview:self.navigationBar aboveSubview:self.contentView];
        
    }
    return self;
}


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [self init];
    if(self) {
        _rootViewController = rootViewController;
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon_20x20.png"] style:UIBarButtonItemStyleBordered target:self.slideMenuController action:@selector(toggleMenu)];
        rootViewController.navigationItem.leftBarButtonItem = menuButton;
        [self addChildViewController:rootViewController];
        [self.contentView addSubview:rootViewController.view];
        [self.navigationBar pushNavigationItem:rootViewController.navigationItem animated:YES];
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)pushViewController:(UIViewController *)controller
{
    [self addChildViewController:controller];
    [self.navigationBar pushNavigationItem:controller.navigationItem animated:YES];
    
    if([self.childViewControllers count] == 1)
    {
        [self.contentView addSubview:controller.view];
    }
    else
    {
        UIViewController *previousController = [self.childViewControllers lastObject];
        [self transitionFromViewController:previousController toViewController:controller duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:NULL completion:NULL];
     }
}

- (UIViewController *)popViewController
{
    UIViewController *controller = [self.childViewControllers lastObject];
    UIViewController *previousController = nil;
    if([self.childViewControllers count] > 1)
    {
        previousController = [self.childViewControllers objectAtIndex:[self.childViewControllers count]-1];
    }
    [controller removeFromParentViewController];
    [self.navigationBar popNavigationItemAnimated:YES];
    [self transitionFromViewController:controller toViewController:previousController duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:NULL completion:NULL];
    
    return controller;
}

- (void)viewDidUnload
{
    _rootViewController = nil;
    self.navigationBar = nil;
    self.contentView = nil;
    
    self.slideMenuController = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [_rootViewController release];
    [navigationBar release];
    [contentView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end