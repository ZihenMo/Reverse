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
*/
#import <substrate.h>
// show the alert if hook success
%hook MZRootViewController
- (void)viewDidAppear:(BOOL)animated{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"注入成功了，呜～喵！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertaction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:alertaction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    %orig;
}
%end

// __ZN8CPPClass7CPPFuncEPKc是CppClass的Symbol。
// 定义旧的函数指针, 函数类型的确定后续学习
void (*old__ZN8CPPClass7CPPFuncEPKc)(void *, const char *);

// 定义新的函数实现,即hooker函数
void new__ZN8CPPClass7CPPFuncEPKc(void *hiddenThis, const char *arg) {
	if (strcmp(arg, "This is a Cpp Function!") == 0) {
		old__ZN8CPPClass7CPPFuncEPKc(hiddenThis, "This is a hijacked Cpp Function!");
	}
	else {
		old__ZN8CPPClass7CPPFuncEPKc(hiddenThis, "This is a hijacked Short C Function!");
	}
}

// define the old c function pointer
void (*old_CFunc)(const char *);

// define the hooker function
void new_CFunc (const char *arg) {
	// just call the original function
	old_CFunc("This is a hijacked C Function!");
}

// ditto
void (*old_ShortCFunction)(const char *);

void new_ShortCFunction(const char *arg) {
	old_ShortCFunction("This is a hijacked Short C Function!!!");
}

%ctor
{
	@autoreleasepool {
		NSLog(@"HookerTweak!!");
		// the implemetation framework (mach-o)
		MSImageRef image = MSGetImageByName("/Applications/ReverseTarget.app/ReverseTarget");
		// find the symbol implementation (memery address) [public symbol]
		void *__ZN8CPPClass7CPPFuncEPKc = MSFindSymbol(image, "__ZN8CPPClass7CPPFuncEPKc");
		if (__ZN8CPPClass7CPPFuncEPKc) {
			// hook the function
			NSLog(@"Found CPP Function!");
			MSHookFunction((void *)__ZN8CPPClass7CPPFuncEPKc, (void *)&new__ZN8CPPClass7CPPFuncEPKc, (void **)&old__ZN8CPPClass7CPPFuncEPKc);	
		}
		void *_CFunc = MSFindSymbol(image, "_CFunc");
		void *_ShortCFunction = MSFindSymbol(image, "_ShortCFunction");
		if (_CFunc) {
			NSLog(@"Found C Function!");
			MSHookFunction((void *)_CFunc, (void *)&new_CFunc, (void **)&old_CFunc);
		}
		if (_ShortCFunction) { // will failed
			NSLog(@"Found Short C Function!");
			MSHookFunction ((void *)_ShortCFunction, (void *)&new_ShortCFunction, (void **)&old_ShortCFunction);
		}
	}
}

