//
//  ShareSDKPlugin.m
//  ShareSDKPlugin
//
//  Created by 刘靖煌 on 16/8/30.
//  Copyright © 2016年 mob.com. All rights reserved.
//

#import "ShareSDKPlugin.h"
#import "MainWindowController.h"

static ShareSDKPlugin *sharedPlugin;

@interface ShareSDKPlugin ()

@property (strong) MainWindowController *windowController;

@end

@implementation ShareSDKPlugin

#pragma mark - Initialization

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    NSArray *allowedLoaders = [plugin objectForInfoDictionaryKey:@"me.delisa.XcodePluginBase.AllowedLoaders"];
    if ([allowedLoaders containsObject:[[NSBundle mainBundle] bundleIdentifier]]) {
        sharedPlugin = [[self alloc] initWithBundle:plugin];
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)bundle
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        _bundle = bundle;
        // NSApp may be nil if the plugin is loaded from the xcodebuild command line tool
        if (NSApp && !NSApp.mainMenu) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(applicationDidFinishLaunching:)
                                                         name:NSApplicationDidFinishLaunchingNotification
                                                       object:nil];
        } else {
            [self initializeAndLog];
        }
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    //系统提供的例子，可删
//    [self initializeAndLog];
    
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *windowMenuItem = [[NSApp mainMenu] itemWithTitle:@"Window"];
    NSMenuItem *pluginManagerItem = [[NSMenuItem alloc] initWithTitle:@"ShareSDK Plugin"
                                                               action:@selector(showMainWindow)
                                                        keyEquivalent:@"8"];
    
    pluginManagerItem.keyEquivalentModifierMask = NSCommandKeyMask | NSShiftKeyMask;
    pluginManagerItem.target = self;
    
    [windowMenuItem.submenu insertItem:pluginManagerItem
                               atIndex:[windowMenuItem.submenu indexOfItemWithTitle:@"Bring All to Front"] - 1];
    
    
}

-(void)showMainWindow
{
    if (!self.windowController.window)
    {
        self.windowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindowController"];
    }
    
    [[self.windowController window] makeKeyAndOrderFront:self];
}

- (void)initializeAndLog
{
    NSString *name = [self.bundle objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *version = [self.bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *status = [self initialize] ? @"loaded successfully" : @"failed to load";
    NSLog(@"🔌 Plugin %@ %@ %@", name, version, status);
}

#pragma mark - Implementation

- (BOOL)initialize
{
    // Create menu items, initialize UI, etc.
    // Sample Menu Item:
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Do Action" action:@selector(doMenuAction) keyEquivalent:@""];
        //[actionMenuItem setKeyEquivalentModifierMask:NSAlphaShiftKeyMask | NSControlKeyMask];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
        return YES;
    } else {
        return NO;
    }
}

// Sample Action, for menu item:
- (void)doMenuAction
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Hello, World"];
    [alert runModal];
}

@end
