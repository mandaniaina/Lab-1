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
    NSInteger essaie;
    NSString *temps;
    NSString *classement;
    int cpt;
}
- (IBAction)debutFin:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    nbSecondePenalite = 0;
    cpt=0;
    temps = @"Temps";
    classement=@"Classement";
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
        [self sauvegarderTemps:false];
        
        ///////////////////////////////////////////////////////Affichage du classement du dernier coureur
        DataClass *obj=[DataClass getInstance];
         NSMutableString *people=[NSMutableString string];
        int length = 9;
        [people appendString:@"Dossard #"];
        for (int j=length; j<15; j++)
        {
            [people appendString:@" "];
        }
         length = 3;
         [people appendString:@"Nom"];
         for (int j=length; j<25; j++)
         {
         [people appendString:@" "];
         }
         
         length = 6;
         [people appendString:@"Prenom"];
         for (int j=length; j<25; j++)
         {
         [people appendString:@" "];
         }
        length=4;
         [people appendString:@"Pays"];
        for (int j=length; j<25; j++)
        {
            [people appendString:@" "];
        }
        
        length= temps.length;
        [people appendString:temps];
        for (int j=length; j<25; j++)
        {
            [people appendString:@" "];
        }
        
        length = classement.length;
        [people appendString:classement];
         [people appendString:@"\n\n"];
        
         /*for (int i=0; i < [obj.listeParticipants count]; i++) {*/
        Participant* p = [obj.listeParticipants objectAtIndex:cpt];
        length = [[NSString stringWithFormat:@"%d",p.No] length];
             [people appendString:[NSString stringWithFormat:@"%d",p.No]];
             for (int j=length; j<15; j++)
             {
                 [people appendString:@" "];
             }
         length = [p.Nom length];
         [people appendString:p.Nom];
         for (int j=length; j<25; j++)
         {
         [people appendString:@" "];
         }
         
         length = [p.Prenom length];
         [people appendString:p.Prenom];
         for (int j=length; j<25; j++)
         {
         [people appendString:@" "];
         }
         
         length = [p.Pays length];
         [people appendString:p.Pays];
             for (int j=length; j<25; j++)
             {
                 [people appendString:@" "];
             }
             [people appendString:[NSString stringWithFormat:@"%d secondes",p.TempsCourse1]];
        length = classement.length;
        for (int j=length; j<25; j++)
        {
            [people appendString:@" "];
        }
        
        int nbrBattue=0;
        int classementActuel=0;
        for(int i =0;i<[obj.listeParticipants count];i++)
        {
            if(cpt!=0 && p.TempsCourse1< [[obj.listeParticipants objectAtIndex:i]TempsCourse1])
            {
                nbrBattue++;
                classementActuel=cpt-nbrBattue+1;
            }
            else if(cpt==0)
            {
                classementActuel=1;
            }
            else if(nbrBattue==0&&cpt!=0)
            {
                classementActuel=cpt+1;
            }
        }
        [people appendString:[NSString stringWithFormat:@"#%d",classementActuel]];
        [people appendString:@"\n"];
        
         //}
         _textview.text=people;
        if(cpt!=[obj.listeParticipants count])
        {
            cpt++;
        }else
        {
            cpt=0;
        }
        ///////////////////////////////////////////////////////
    }
    
}

- (IBAction)penalite:(UIButton *)sender {
    
    // DataClass *obj=[DataClass getInstance];
    nbSecondePenalite = nbSecondePenalite + 30;
    
    int secondes = nbSecondePenalite % 60;
    int minutes = (nbSecondePenalite / 60) % 60;
    
    if(nbSecondePenalite >= 90){
        
        [self->lbPenalite setText: @"Disqualifié"];
        [chrono invalidate], chrono = nil;
        [self sauvegarderTemps:true];
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
- (IBAction)disqualifie:(id)sender {
    
    [self->lbPenalite setText: @"Disqualifié"];
    [chrono invalidate], chrono = nil;
    [self sauvegarderTemps:true];
}

-(void) afficherChrono{
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:debutChrono];
    
    essaie=timeInterval;
    
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

- (void) sauvegarderTemps:(bool) estDisqualifie{
    DataClass *obj=[DataClass getInstance];
        NSDate *currentDate = [NSDate date];
        NSTimeInterval secondeChrono = [currentDate timeIntervalSinceDate:debutChrono];
        NSInteger tempsChrono = secondeChrono;
        
        
        if(obj.participantEnCours > [obj.listeParticipants  count]){
            obj.participantEnCours = 0;
            obj.tourNo2 = true;
        }
        
        Participant *p = obj.listeParticipants[cpt];
        
        if(!obj.tourNo2){
            if(estDisqualifie){
                p.TempsCourse1 = -1;
            }else{
                p.TempsCourse1 =  nbSecondePenalite + (int)tempsChrono; //ajouter le temps du chrono
                NSLog(@"%d",p.TempsCourse1);
            }
        }else{
            if(estDisqualifie){
                p.TempsCourse2 = -1;
            }else
                p.TempsCourse2 = (int)&(nbSecondePenalite) + (int)tempsChrono; //ajouter temps chrono
        }
        
        nbSecondePenalite = 0;
        
        if(obj.participantEnCours > [obj.listeParticipants  count] && obj.tourNo2 == true){
            //ALERT fin de la compétition
            //clear données
            
            
        }
}


@end
