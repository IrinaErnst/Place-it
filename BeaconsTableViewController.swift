//Create new template file => (Cocoa Touch) UIViewController subclass
//HerokuTableViewController will download and parse the JSON response from 
//the API, and display the result in a ULtableView.


#import <UIKit>

@interface HerokuTableViewController : UITableViewController
@property (nonatomic, retain) NSArray *beacons;
@end

static NSString * const kMyAppBaseURLString = @"http://frozen-shelf-4349.herokuapp.com/";
