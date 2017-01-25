//
//  SecondViewController.m
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

@interface SecondViewController (){
    NSTimer *chrono;
    NSDate *debutChrono;
    __weak IBOutlet UILabel *lbTimer;
    __weak IBOutlet UILabel *lbPenalite;
    int nbSecondePenalite;
}
- (IBAction)debutFin:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    nbSecondePenalite = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)timerButton:(UIButton *)sender {
    
       if(![chrono isValid]){
           [sender setTitle:@"Arrivée" forState:UIControlStateNormal];
        
        debutChrono = [NSDate date];
        chrono = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(afficherChrono) userInfo:nil repeats:YES];
        
    }else{
        [chrono invalidate], chrono = nil;
        [sender setTitle:@"Départ" forState:UIControlStateNormal];
    }
    
}

- (IBAction)penalite:(UIButton *)sender {
    
   // DataClass *obj=[DataClass getInstance];
    nbSecondePenalite = nbSecondePenalite + 30;
    
    int secondes = nbSecondePenalite % 60;
    int minutes = (nbSecondePenalite / 60) % 60;
    
    if(nbSecondePenalite == 60){
    
         [self->lbPenalite setText: @"Disqualifié"];
         [chrono invalidate], chrono = nil;
    }
    else{
        NSString* strPenalite = [NSString stringWithFormat:@"%02d:%02d",minutes,secondes];
        
        [self->lbPenalite setText: [@"Pénalité:" stringByAppendingString:strPenalite]];
    }
    
    /*
    NSMutableString *people=[NSMutableString string];
    int length = 3;
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
        int length = [p.Nom length];
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
    _textview.text=people;*/
}

-(void) afficherChrono{
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:debutChrono];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // create the date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeStr = [dateFormatter stringFromDate:timerDate];
    
    //set the text to your label
    [self->lbTimer setText:timeStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)debutFin:(id)sender {
    DataClass *obj=[DataClass getInstance];
    NSLog(@"%@", obj.listeParticipants);
}
@end
