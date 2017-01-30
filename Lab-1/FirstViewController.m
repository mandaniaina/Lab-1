//
//  FirstViewController.m
//  Lab-1
//
//  Created by Raharison, Mandaniaina on 2017-01-16.
//  Copyright © 2017 Raharison, Mandaniaina. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import "AppDelegate.h"
#import "participant.h"
#import "DataClass.h"
@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nom;
@property (weak, nonatomic) IBOutlet UITextField *prenom;
@property (weak, nonatomic) IBOutlet UITextField *pays;

- (IBAction)btnAjouter:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *textview;


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
    p.No = obj.noMax +1;
    obj.noMax = obj.noMax+1;
    [obj.listeParticipants addObject:p];
    
    NSMutableString *people=[NSMutableString string];
    int length = 9;
    [people appendString:@"Dossard #"];
    for (int j=length; j<15; j++)
    {
        [people appendString:@" "];
    }
    length = 3;
    [people appendString:@"Nom"];
    for (int j=length; j<40; j++)
    {
        [people appendString:@" "];
    }
    
    length = 6;
    [people appendString:@"Prenom"];
    for (int j=length; j<40; j++)
    {
        [people appendString:@" "];
    }
    [people appendString:@"Pays"];
    [people appendString:@"\n\n"];
    for (int i=0; i < [obj.listeParticipants count]; i++) {
        Participant* p = [obj.listeParticipants objectAtIndex:i];
        int length = [[NSString stringWithFormat:@"%d",p.No] length];
        [people appendString:[NSString stringWithFormat:@"%d",p.No]];
        for (int j=length; j<15; j++)
        {
            [people appendString:@" "];
        }
        length = [p.Nom length];
        [people appendString:p.Nom];
        for (int j=length; j<40; j++)
        {
            [people appendString:@" "];
        }
        
        length = [p.Prenom length];
        [people appendString:p.Prenom];
        for (int j=length; j<40; j++)
        {
            [people appendString:@" "];
        }
        
        length = [p.Pays length];
        [people appendString:p.Pays];
        [people appendString:@"\n"];
    }
    _textview.text=people;
    
    _nom.text = @"";
    _prenom.text = @"";
    _pays.text = @"";

}
@end
