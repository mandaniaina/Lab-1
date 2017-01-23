//
//  DataClass.m
//  Lab-1
//
//  Created by Leclerc, Vincent on 2017-01-23.
//  Copyright © 2017 Raharison, Mandaniaina. All rights reserved.
//

#import "DataClass.h"

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
            instance= [[DataClass alloc]init];
            instance.listeParticipants =  [[NSMutableArray alloc] init];
        }
    }
    return instance;
}
@end
