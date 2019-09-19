/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end

%hook SpringBoard 
- (void)_menuButtonDown:(id)down  { 
	NSLog(@"你按了Home键，找打！");       
	%log((NSString *)@"iOSRE", (NSString *)@"Debug");	// 将当前函数的签名与所属类写入系统日志
	%orig; // 调用原有功能
}
%end


// 修改锁屏界面
%hook SBLockScreenDateViewController
 - (void)setCustomSubtitleText:(id)arg1 withColor:(id)arg2 {
	%orig(@"独一无二的锁屏信息之梁豆豆", arg2); 	// 修改原有函数入参
}
%end
*/
%hook SpringBoard
// - (void)applicationDidFinishLaunching:(id)application {     
// 	%orig;     
// 	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"豆豆专用破手机！" message:nil delegate:self cancelButtonTitle:@"臣妾领命" otherButtonTitles:nil];    
// 	[alert show];
// } 

//- (void)menuButtonDown:(struct __GSEvent *)arg1; iOS 7之前
//- (void)_menuButtonDown:(struct __IOHIDEvent *)arg1; iOS 7之后
- (void)_menuButtonDown:(struct __IOHIDEvent *)arg1 {
	NSLog(@"你按了Home键，找打！");       
	%log((NSString *)@"iOSRE", (NSString *)@"Debug");	// 将当前函数的签名与所属类写入系统日志
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你按了Home键！" message:nil delegate:self cancelButtonTitle:@"臣妾遵旨" otherButtonTitles:nil]; 
	[alert show];
	%orig; // 调用原有功能
}
%end














