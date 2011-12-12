//
//  JWSlideMenuController.m
//  JWSlideMenu
//
//  Created by Jeremie Weldin on 11/14/11.
//  Copyright (c) 2011 Jeremie Weldin. All rights reserved.
//

#import "JWSlideMenuController.h"
#import "JWNavigationController.h"
#import "JWSlideMenuViewController.h"

@implementation JWSlideMenuController

@synthesize menuTableView;
@synthesize menuTableView2;
@synthesize menuView;
@synthesize menuView2;
@synthesize contentToolbar;
@synthesize contentView;
@synthesize menuLabelColor;

- (id)init
{
    self = [super init];
    if (self) {
        
        CGRect masterRect = self.view.bounds;
        float menuWidth = masterRect.size.width -53; //masterRect.size.width - 53
        
        CGRect menuFrame = CGRectMake(0.0, 0.0, menuWidth, masterRect.size.height);
        CGRect contentFrame = CGRectMake(0.0, 0.0, masterRect.size.width, masterRect.size.height);
      
      
      CGRect menuFrame2 = CGRectMake(53, 0.0, menuWidth, masterRect.size.height);

        
        self.menuLabelColor = [UIColor whiteColor];
        
        self.menuTableView = [[[UITableView alloc] initWithFrame:menuFrame] autorelease];
        self.menuTableView.dataSource = self;
        self.menuTableView.delegate = self;
        self.menuTableView.backgroundColor = [UIColor darkGrayColor];
        self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.menuTableView.separatorColor = [UIColor whiteColor];
      
      self.menuTableView2 = [[[UITableView alloc] initWithFrame:menuFrame] autorelease];
      self.menuTableView2.dataSource = self;
      self.menuTableView2.delegate = self;
      self.menuTableView2.backgroundColor = [UIColor blueColor];
      self.menuTableView2.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
      self.menuTableView2.separatorColor = [UIColor whiteColor];
      
      
        self.menuView = [[[UIView alloc] initWithFrame:menuFrame] autorelease];
        [self.menuView addSubview:self.menuTableView];
      
      self.menuView2 = [[[UIView alloc] initWithFrame:menuFrame2] autorelease];
      [self.menuView2 addSubview:self.menuTableView2];
                
        self.contentView = [[[UIView alloc] initWithFrame:contentFrame] autorelease];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.contentView.backgroundColor = [UIColor grayColor];
        
        [self.view addSubview:self.menuView];
        [self.view addSubview:self.menuView2];
        [self.view insertSubview:self.contentView aboveSubview:self.menuView2];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)toggleMenu2
{
  
  [UIView beginAnimations:@"Menu Slide" context:nil];
  [UIView setAnimationDuration:0.2];
  
  if(self.contentView.frame.origin.x == 0) //Menu is hidden
  {
    CGRect newFrame = CGRectOffset(self.contentView.frame, -(self.menuView.frame.size.width), 0.0);
    self.contentView.frame = newFrame;
    self.menuTableView.hidden=YES;
    
    CGRect masterRect = self.view.bounds;
    float menuWidth = masterRect.size.width -53; //masterRect.size.width - 53
    CGRect menuFrame2 = CGRectMake(53, 0.0, menuWidth, masterRect.size.height);
    self.menuView2.frame=menuFrame2;
    
    self.menuTableView2.hidden=NO;
  }
  else //Menu is shown
  {
    [menuTableView reloadData];
    CGRect newFrame = CGRectOffset(self.contentView.frame, (self.menuView.frame.size.width), 0.0);
    self.contentView.frame = newFrame;
        self.menuTableView.hidden=YES;
  }
  
  [UIView commitAnimations];
}

-(IBAction)toggleMenu
{
    
    [UIView beginAnimations:@"Menu Slide" context:nil];
    [UIView setAnimationDuration:0.2];
        
    if(self.contentView.frame.origin.x == 0) //Menu is hidden
    {
        CGRect newFrame = CGRectOffset(self.contentView.frame, self.menuView.frame.size.width, 0.0);
        self.contentView.frame = newFrame;
        self.menuView2.frame= newFrame;
        self.menuTableView.hidden=NO;
        //self.menuTableView2.hidden=YES;
    }
    else //Menu is shown
    {
        [menuTableView reloadData];
        CGRect newFrame = CGRectOffset(self.contentView.frame, -(self.menuView.frame.size.width), 0.0);
        self.contentView.frame = newFrame;
    }
    
    [UIView commitAnimations];
}

-(JWNavigationController *)addViewController:(JWSlideMenuViewController *)controller withTitle:(NSString *)title andImage:(UIImage *)image
{
    JWNavigationController *navController = [[[JWNavigationController alloc] initWithRootViewController:controller] autorelease];
    navController.slideMenuController = self;
    navController.title = title;
    navController.tabBarItem.image = image;

    [self addChildViewController:navController];
    
    if([self.childViewControllers count] == 1)
    {
        [self.contentView addSubview:navController.view];
    }
    
    return navController;
}

#pragma mark - UITableViewDataSource/Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  if(tableView==self.menuTableView) {
    static NSString *cellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        // Do something here......................
    }
    
    //TODO: either support tabbaritem or a protocol in order to handle images in the menu.
    
    UIViewController *controller = (UIViewController *)[self.childViewControllers objectAtIndex:indexPath.row] ;
    cell.textLabel.text = controller.title;
    cell.textLabel.textColor = menuLabelColor;
    
    cell.imageView.image = controller.tabBarItem.image;
    
    return cell;
  }
  return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
  if(tableView==self.menuTableView) {
    return [self.childViewControllers count];
  }
  return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    if([contentView.subviews count] == 1){
        [[contentView.subviews objectAtIndex:0] removeFromSuperview];
    }
    
    UIViewController* controller = (UIViewController*)[self.childViewControllers objectAtIndex:indexPath.row];
    controller.view.frame = self.contentView.bounds;
    
    [contentView addSubview:controller.view];
    [self toggleMenu];
}
 

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setMenuView:nil];
    [self setContentView:nil];
    [self setMenuTableView:nil];
    [self setMenuLabelColor:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    [menuView release];
    [contentView release];
    [contentToolbar release];
    [menuTableView release];
    [menuLabelColor release];
    [super dealloc];
}
@end
