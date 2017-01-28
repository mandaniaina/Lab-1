//
//  Participant.h
//  Lab-1
//
//  Created by Déry, Gabriel on 2017-01-23.
//  Copyright © 2017 Raharison, Mandaniaina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Participant : NSObject
{
    NSString *Nom;
    NSString *Prenom;
    NSString *Pays;
    int *TempsCourse1;
    int *TempsCourse2;
    int *No;
}
@property(nonatomic, readwrite) NSString *Nom;
@property(nonatomic, readwrite) NSString *Prenom;
@property(nonatomic, readwrite) NSString *Pays;
@property(nonatomic, readwrite) int TempsCourse1;
@property(nonatomic, readwrite) int TempsCourse2;
@property(nonatomic, readwrite) int No;
@end
