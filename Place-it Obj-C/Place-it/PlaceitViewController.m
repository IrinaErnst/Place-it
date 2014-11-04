//
//  PlaceitViewController.m
//  
//
//  Created by Irina Kalashnikova on 10/31/14.
//
//

#import "PlaceitViewController.h"

static NSString * const kPlaceItBaseURLString = @"http://enigmatic-hamlet-8908.herokuapp.com";

@interface PlaceitViewController ()

@end

@implementation PlaceitViewController
@synthesize rooms = _rooms;

#pragma mark - UIViewController

//Method: set a view controller's title and begin a network request to the API to get the list of rooms to display
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Place-it", nil);
    
    NSURL *url = [NSURL URLWithString:[kPlaceItBaseURLString stringByAppendingPathComponent:@"rooms.json"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //"AFJSONRequestOperation'-Will asynchronously load data from API and execute the block in the 'success' parametr when the request completes.
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTPURLResponse *response, id JSON)
    		self.rooms = [JSON valueForKey:@"rooms"];
    		[self.tableView reloadData];
    	} failure:^(NSURLRequest *request, NSHTPURLResponse *response, NSError *error, id JSON) {
    		NSLog(@"Error: Pls chaeck PlaceitViewController.m", error);	
    	}];
    	[operation start];
}

- (NSInteger)tableView:(USTableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.rooms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIndentifier = @"Cell";

	UITableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (!cell){
		cell = [[[UITableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier] autorelease];
	}

	cell.textLabel.text = [self.sushi objectAtIndex:indexPath.row];

	return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
