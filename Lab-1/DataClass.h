//
//  DataClass.h
//  Lab-1
//
//  Created by Leclerc, Vincent on 2017-01-23.
//  Copyright © 2017 Raharison, Mandaniaina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataClass : NSObject
{
    NSMutableArray *listeParticipants;
}

@property(nonatomic,retain)NSMutableArray *listeParticipants;
+(DataClass*)getInstance;
@end
