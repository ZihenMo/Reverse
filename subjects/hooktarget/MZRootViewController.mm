#import "MZRootViewController.h"


class CPPClass {
public:
    void CPPFunc(const char *);
};
void CPPClass::CPPFunc(const char *arg) {
	for (int i = 0; i < 66; ++i) // 让函数拥有足够长的指令以检验MSHookFunction
	{
		u_int32_t randomNumber;
		if (i % 3) {
			randomNumber = arc4random_uniform(i);
        }
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        NSString *hostName = processInfo.hostName;
        int pid = processInfo.processIdentifier;
        NSString *globallyUniqueString = processInfo.globallyUniqueString;
        NSString *processName = processInfo.processName;
        NSString *junk = @"";
        NSArray *junks = @[hostName, globallyUniqueString, processName];
        int j = 0;
        for (j = 0; j < pid; ++j) {
            if (pid % 6 == 0) junk = junks[j % 3];
        }
        if (j % 68 == 1) {
            NSLog(@"junk: %@", junk);
        }
	}
    NSLog(@"iOSRE: CPPFunc %s", arg);
}

extern "C" void CFunc(const char *arg) {
    for (int i = 0; i < 66; ++i) // 让函数拥有足够长的指令以检验MSHookFunction
    {
        u_int32_t randomNumber;
        if (i % 3) {
            randomNumber = arc4random_uniform(i);
        }
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        NSString *hostName = processInfo.hostName;
        int pid = processInfo.processIdentifier;
        NSString *globallyUniqueString = processInfo.globallyUniqueString;
        NSString *processName = processInfo.processName;
        NSString *junk = @"";
        NSArray *junks = @[hostName, globallyUniqueString, processName];
        int j = 0;
        for (j = 0; j < pid; ++j) {
            if (pid % 6 == 0) junk = junks[j % 3];
        }
        if (j % 68 == 1) {
            NSLog(@"junk: %@", junk);
        }
    }
    NSLog(@"iOSRE: CFunc %s", arg);
}
 // ShortCFunction is too short to be hooked
extern "C" void ShortCFunction(const char *arg0) {
    CPPClass cppClass;
    cppClass.CPPFunc(arg0);
}
@implementation MZRootViewController {
	NSMutableArray *_objects;
}

- (void)loadView {
	[super loadView];
	_objects = [NSMutableArray array];
    
	self.title = @"Root View Controller";
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)hookTest {
    CPPClass cppClass;
    cppClass.CPPFunc("This is a Cpp Function!");
    CFunc("This is a C Function!");
    ShortCFunction("This is a C Short Function!");
}

- (void)addButtonTapped:(id)sender {
	[_objects insertObject:[NSDate date] atIndex:0];
	[self.tableView insertRowsAtIndexPaths:@[ [NSIndexPath indexPathForRow:0 inSection:0] ] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self hookTest];
    NSLog(@"Hello!");
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	NSDate *date = _objects[indexPath.row];
	cell.textLabel.text = date.description;
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	[_objects removeObjectAtIndex:indexPath.row];
	[tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
