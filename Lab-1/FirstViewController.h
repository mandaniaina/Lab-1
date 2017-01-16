//
//  FirstViewController.h
//  Lab-1
//
//  Created by Raharison, Mandaniaina on 2017-01-16.
//  Copyright © 2017 Raharison, Mandaniaina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@end
@interface Participant : NSObject
{
    NSString *Nom;
    NSString *Prenom;
    NSString *Pays;
    int *Temp;
    int *No;
}
@property(nonatomic, readwrite) NSString *Nom;
@property(nonatomic, readwrite) NSString *Prenom;
@property(nonatomic, readwrite) NSString *Pays;
@property(nonatomic, readwrite) int *Temp;
@property(nonatomic, readwrite) int *No;
@end
