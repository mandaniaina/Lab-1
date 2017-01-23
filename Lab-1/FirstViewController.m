//
//  FirstViewController.m
//  Lab-1
//
//  Created by Raharison, Mandaniaina on 2017-01-16.
//  Copyright © 2017 Raharison, Mandaniaina. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "Participant.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nom;
@property (weak, nonatomic) IBOutlet UITextField *prenom;
@property (weak, nonatomic) IBOutlet UITextField *pays;
- (IBAction)btnAjouter:(UIButton *)sender;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAjouter:(UIButton *)sender {
    Participant *p = [[Participant alloc]init];
    p.Nom = _nom.text;
    p.Prenom = _prenom.text;
    p.Pays = _pays.text;
    
    DataClass *obj=[DataClass getInstance];
    [obj.listeParticipants addObject:p];
}
@end
