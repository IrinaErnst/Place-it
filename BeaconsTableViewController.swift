//Create new template file => (Cocoa Touch) UIViewController subclass
//HerokuTableViewController will download and parse the JSON response from 
//the API, and display the result in a ULtableView.





// COCOA PODS VIEW CONTROLLER --- this is response from Heroku 
// URL connected to server where server waiting for 3 parametrs from our app
// 1. UUID == B9407F30-F5F8-466E-AFF9-25556B57FE6D, 
// 2. maj_val == 1 (for all 3 beacons), 
// 3. min_val == 1 (or 2, or 3).
// respons msg

// didFinishLaunchingWithOptions method add following:
func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
    var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:5000/beacons.json"))
    var session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
     
    var params = ["beacon_id":"beacon_id", "maj_val":"maj_val", "min_val":"min_val",] as Dictionary<String, Integer, Integer>
     
    var err: NSError?
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
     
    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        println("Response: \(response)")
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Body: \(strData)")
        var err: NSError?
        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
         
        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
        if(err != nil) {
            println(err!.localizedDescription)
            let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Error could not parse JSON: '\(jsonStr)'")
        }
        else {
            // The JSONObjectWithData constructor didn't return an error. But, we should still
            // check and make sure that json has a value using optional binding.
            if let parseJSON = json {
                // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                var success = parseJSON["success"] as? Int
                println("Succes: \(success)")
            }
            else {
                // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: \(jsonStr)")
            }
        }
    })
     
    task.resume()
    return true
}


//2nd OPTION:



#import <UIKit>

@property (nonatomic, retain) NSArray *beacons;


static NSString * const kMyAppBaseURLString = @"http://frozen-shelf-4349.herokuapp.com/"


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Beacons", nil);

    NSURL *url = [NSURL URLWithString:[kMyAppBaseURLString stringByAppendingPathComponent:@"beacons.json"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, name JSON) {
        self.beacons = [JSON valueForKey:@"beacons"];
        [self.tableView reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, name JSON) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sushi count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    cell.textLabel.text = [self.sushi objectAtIndex:indexPath.row];

    return cell;
}

@end





/// APP DELEGATE

#import <UIKit/UIKit.h>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;



- (void)dealloc {
    [_window release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];

    //If we are putting previos code in MessageManager.swift
    MessageManager *message = [[[MessageManager alloc] initWithStyle:UITableViewStylePlain] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
    [self.window addSubview:self.navigationController.view];

    [self.window makeKeyAndVisible];

    return YES;
}

@end

// In Xcode, click the “Run” play button, or use the keyboard shortcut, ⌘R. // If everything worked, your app should be displaying 
// the results fetched from your API.
