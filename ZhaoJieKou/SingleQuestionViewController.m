//
//  SingleQuestionViewController.m
//  ZhaoJieKou
//
//  Created by Yu Jianjun on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SingleQuestionViewController.h"
#import "QuestionHeaderView.h"
#import "AnswerTableViewCell.h"

#define kCellHeight 100.0

@implementation SingleQuestionViewController
@synthesize qaTableView;
@synthesize customNavigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    selectedIndexes = [[NSMutableDictionary alloc] init];
    
    QuestionHeaderView *headerView;
    
    NSArray* nibViews =  [[NSBundle mainBundle] loadNibNamed:@"QuestionHeaderView" owner:nil options:nil];
    for (id object in nibViews) {
        if ([object isKindOfClass:[QuestionHeaderView class]]) {
            headerView = (QuestionHeaderView *)object;
            break;
        }
    }
    
    self.qaTableView.tableHeaderView = headerView;
    
   // [self.qaTableView reloadData];
    
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"3个回答"];
    
  //  [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"titleBG.png"]];
    
    customNavigationBar.navigationController = self.navigationController;
    
    // Create a custom back button
    UIButton* backButton = [customNavigationBar backButtonWith:[UIImage imageNamed:@"bar_button.png"] highlight:nil leftCapWidth:17.0];
    
    [customNavigationBar setText:@"返回" onBackButton:backButton];
    
    navItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];   
    
    
    
    [customNavigationBar pushNavigationItem:navItem animated:NO];
    
    [navItem release];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = @"如何找借口吻女生";
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines = 0;
    
    cell.detailTextLabel.text = @"先买两块糖,(不同口味的硬糖,不要棒棒)每人嘴里放一块.你先莫名其妙站起来绕她转一圈,然后她会很奇怪地看你.你面无表情,之后把嘴里的糖吐掉.";
    */
    
    static NSString *CellIdentifier = @"AnswerTableViewCell";
    
    AnswerTableViewCell *cell = (AnswerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AnswerTableViewCell" owner:nil options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (AnswerTableViewCell *) currentObject;
                
                break;
            }
        }
    }
    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height)];
//    
//    [bgView setBackgroundColor:[UIColor blackColor]];
//    
//    cell.backgroundView = bgView;
//    
//    [bgView release];
//
//    return cell;
    
    return cell;
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
	// Return whether the cell at the specified index path is selected or not
	NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// If our cell is selected, return double height
	if([self cellIsSelected:indexPath]) {
		return kCellHeight * 2.0;
	}
	// Cell isn't selected so return single height
	return kCellHeight;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    
    
    // Deselect cell
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	// Toggle 'selected' state
	BOOL isSelected = ![self cellIsSelected:indexPath];
	// Store cell 'selected' state keyed on indexPath
	NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
	[selectedIndexes setObject:selectedIndex forKey:indexPath];
	// This is where magic happens...
	[qaTableView beginUpdates];
	[qaTableView endUpdates];
}

- (void)viewDidUnload
{
    [self setQaTableView:nil];
    
    
    [selectedIndexes release];
	selectedIndexes = nil;
    
    [self setCustomNavigationBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [qaTableView release];
    [customNavigationBar release];
    [super dealloc];
}
@end
