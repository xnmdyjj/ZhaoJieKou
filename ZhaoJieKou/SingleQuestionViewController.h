//
//  SingleQuestionViewController.h
//  ZhaoJieKou
//
//  Created by Yu Jianjun on 4/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationBar.h"

@interface SingleQuestionViewController : UIViewController {
    
    NSMutableDictionary *selectedIndexes;
}
@property (retain, nonatomic) IBOutlet UITableView *qaTableView;
@property (retain, nonatomic) IBOutlet CustomNavigationBar *customNavigationBar;

@end
