//
//  AppDelegate.h
//  Lab-1
//
//  Created by Raharison, Mandaniaina on 2017-01-16.
//  Copyright © 2017 Raharison, Mandaniaina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@end

@interface DataClass : NSObject
{
    NSMutableArray *listeParticipants;
}

@property(nonatomic,retain)NSMutableArray *listeParticipants;
+(DataClass*)getInstance;
@end


//DataClass.m
@implementation DataClass
@synthesize listeParticipants;

static DataClass *instance = nil;

+(DataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DataClass new];
            instance.listeParticipants =  [[NSMutableArray alloc] init];
        }
    }
    return instance;
}
@end
