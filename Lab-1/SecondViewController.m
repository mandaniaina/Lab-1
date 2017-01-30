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
    __weak IBOutlet UILabel *lbParticipant;
    __weak IBOutlet UILabel *lbTour;
    __weak IBOutlet UIButton *timerButton;
    int nbSecondePenalite;
    NSInteger essaie;
    NSString *temps;
    NSString *classement;
    int cpt;
    int cpt2;
    UIAlertController *alert;
    Participant *premier;
    /*int first;
    int second;
    int third;
    bool trouvePremier;
    bool trouveDeuxieme;
    bool trouveTroisieme;*/
    //NSData *buffer;
}
- (IBAction)debutFin:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UITextView *nextAthleteview;
@property (weak, nonatomic) IBOutlet UITextView *generalRankview;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    nbSecondePenalite = 0;
    cpt=0;
    cpt2=0;
    temps = @"Temps";
    classement=@"Classement";
    DataClass *obj=[DataClass getInstance];
    NSMutableString *premierParticipant=[NSMutableString string];
    if([obj.listeParticipants count]!= 0) {
        premier = [obj.listeParticipants objectAtIndex:0];
        [premierParticipant appendString:@"#"];
        [premierParticipant appendString:[NSString stringWithFormat:@"%d",premier.No]];
        [premierParticipant appendString:@" "];
        [premierParticipant appendString:premier.Nom];
        [premierParticipant appendString:@" "];
        [premierParticipant appendString:premier.Prenom];
        [premierParticipant appendString:@" , "];
        [premierParticipant appendString:premier.Pays];
        [lbParticipant setText:premierParticipant];
        [lbTour setText:@"Tour #1"];
        
    }
    /*trouvePremier=false;
    trouveDeuxieme=false;
    trouveTroisieme=false;*/
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)timerButton:(UIButton *)sender {
    DataClass *obj=[DataClass getInstance];
    if(![chrono isValid] && [obj.listeParticipants count]!= 0){
        [sender setTitle:@"Arrivée" forState:UIControlStateNormal];
        [lbPenalite setText: @"+00:00"];
        debutChrono = [NSDate date];
        chrono = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(afficherChrono) userInfo:nil repeats:YES];
        
    }else{
        if([obj.listeParticipants count]!= 0) {
        [chrono invalidate], chrono = nil;
        [sender setTitle:@"Départ" forState:UIControlStateNormal];
        [self sauvegarderTemps:false];
        
        ///////////////////////////////////////////////////////Affichage du classement du dernier coureur
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
        if(!obj.tourNo2){
            if(p.estDisqualifier == true)
            {
                [people appendString:@"DNF"];
            }
            else{
            [people appendString:[NSString stringWithFormat:@"%d secondes",p.TempsCourse1]];
            }
        }
        else{
            if(p.estDisqualifier == true)
            {
                [people appendString:@"DNF"];
            }
            else{
                [people appendString:[NSString stringWithFormat:@"%d secondes",p.TempsCourse1+p.TempsCourse2]];
            }
        }
             
        length = classement.length;
        for (int j=length; j<25; j++)
        {
            [people appendString:@" "];
        }
        
        int nbrBattue=0;
        int classementActuel=0;
        if(!obj.tourNo2){
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
        }}
        else{
            for(int i =0;i<[obj.listeParticipants count];i++)
            {
                if(cpt!=0 && p.TempsCourse1+p.TempsCourse2 < [[obj.listeParticipants objectAtIndex:i]TempsCourse1]+[[obj.listeParticipants objectAtIndex:i]TempsCourse2] && [[obj.listeParticipants objectAtIndex:i]TempsCourse1]+[[obj.listeParticipants objectAtIndex:i]TempsCourse2]!= [[obj.listeParticipants objectAtIndex:i]TempsCourse1])
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
                }                                                                             }
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
        
        ///////////////////////////////////////////////////////Affichage du prochain coureur
        
        NSMutableString *nextOnes=[NSMutableString string];
        length = 9;
        [nextOnes appendString:@"Dossard #"];
        for (int j=length; j<15; j++)
        {
            [nextOnes appendString:@" "];
        }
        length = 3;
        [nextOnes appendString:@"Nom"];
        for (int j=length; j<25; j++)
        {
            [nextOnes appendString:@" "];
        }
        
        length = 6;
        [nextOnes appendString:@"Prenom"];
        for (int j=length; j<25; j++)
        {
            [nextOnes appendString:@" "];
        }
        length=4;
        [nextOnes appendString:@"Pays"];
        for (int j=length; j<25; j++)
        {
            [nextOnes appendString:@" "];
        }

        [nextOnes appendString:@"\n\n"];
        
        if(obj.listeParticipants.count==2)
        {
            for(int i=0; i<2;i++)
            {
                Participant* pp;
                if(cpt2==1)
                {
                    pp = [obj.listeParticipants objectAtIndex:cpt2-i];
                    
                }else{
                    pp = [obj.listeParticipants objectAtIndex:cpt2+i];
                }
                length = [[NSString stringWithFormat:@"%d",pp.No] length];
                [nextOnes appendString:[NSString stringWithFormat:@"%d",pp.No]];
                for (int j=length; j<15; j++)
                {
                    [nextOnes appendString:@" "];
                }
                length = [pp.Nom length];
                [nextOnes appendString:pp.Nom];
                for (int j=length; j<25; j++)
                {
                    [nextOnes appendString:@" "];
                }
                
                length = [pp.Prenom length];
                [nextOnes appendString:pp.Prenom];
                for (int j=length; j<25; j++)
                {
                    [nextOnes appendString:@" "];
                }
                
                length = [pp.Pays length];
                [nextOnes appendString:pp.Pays];
                for (int j=length; j<25; j++)
                {
                    [nextOnes appendString:@" "];
                }
                
                [nextOnes appendString:@"\n"];            }
        }else if (obj.listeParticipants.count==1)
        {
            Participant* pppp = [obj.listeParticipants objectAtIndex:0];
            length = [[NSString stringWithFormat:@"%d",pppp.No] length];
            [nextOnes appendString:[NSString stringWithFormat:@"%d",pppp.No]];
            for (int j=length; j<15; j++)
            {
                [nextOnes appendString:@" "];
            }
            length = [pppp.Nom length];
            [nextOnes appendString:pppp.Nom];
            for (int j=length; j<25; j++)
            {
                [nextOnes appendString:@" "];
            }
            
            length = [pppp.Prenom length];
            [nextOnes appendString:pppp.Prenom];
            for (int j=length; j<25; j++)
            {
                [nextOnes appendString:@" "];
            }
            
            length = [pppp.Pays length];
            [nextOnes appendString:pppp.Pays];
            for (int j=length; j<25; j++)
            {
                [nextOnes appendString:@" "];
            }
            
            [nextOnes appendString:@"\n"];
        }
        else
        {
        
        for (int i=0; i < 3; i++)
        {
            Participant* ppp;
            if(cpt2==obj.listeParticipants.count-2&&i==2)
            {
                ppp = [obj.listeParticipants objectAtIndex:0];
            }
            else if(cpt2==obj.listeParticipants.count-1&&i==1)
            {
                ppp = [obj.listeParticipants objectAtIndex:0];
            }
            else if(cpt2==obj.listeParticipants.count-1&&i==2)
            {
                ppp = [obj.listeParticipants objectAtIndex:1];
            }
            else
            {
              ppp = [obj.listeParticipants objectAtIndex:(cpt2+i)];
            }
            
        length = [[NSString stringWithFormat:@"%d",ppp.No] length];
        [nextOnes appendString:[NSString stringWithFormat:@"%d",ppp.No]];
        for (int j=length; j<15; j++)
        {
            [nextOnes appendString:@" "];
        }
        length = [ppp.Nom length];
        [nextOnes appendString:ppp.Nom];
        for (int j=length; j<25; j++)
        {
            [nextOnes appendString:@" "];
        }
        
        length = [ppp.Prenom length];
        [nextOnes appendString:ppp.Prenom];
        for (int j=length; j<25; j++)
        {
            [nextOnes appendString:@" "];
        }
        
        length = [ppp.Pays length];
        [nextOnes appendString:ppp.Pays];
        for (int j=length; j<25; j++)
        {
            [nextOnes appendString:@" "];
        }
        
        [nextOnes appendString:@"\n"];
        
        }
        }
        _nextAthleteview.text=nextOnes;
        if(cpt2!=[obj.listeParticipants count])
        {
            cpt2++;
        }else
        {
            cpt2=0;
        }
        ///////////////////////////////////////////////////////
        
        ///////////////////////////////////////////////////////Affichage du classement 3 meilleur
        NSMutableString *meilleurs=[NSMutableString string];
        length = 9;
        [meilleurs appendString:@"Dossard #"];
        for (int j=length; j<15; j++)
        {
            [meilleurs appendString:@" "];
        }
        length = 3;
        [meilleurs appendString:@"Nom"];
        for (int j=length; j<25; j++)
        {
            [meilleurs appendString:@" "];
        }
        
        length = 6;
        [meilleurs appendString:@"Prenom"];
        for (int j=length; j<25; j++)
        {
            [meilleurs appendString:@" "];
        }
        length=4;
        [meilleurs appendString:@"Pays"];
        for (int j=length; j<25; j++)
        {
            [meilleurs appendString:@" "];
        }
        
        length= temps.length;
        [meilleurs appendString:temps];
        for (int j=length; j<25; j++)
        {
            [meilleurs appendString:@" "];
        }
        
        length = classement.length;
        [meilleurs appendString:classement];
        [meilleurs appendString:@"\n\n"];
        
        ////tri
        DataClass *tri;
        tri=[DataClass getInstance];
        tri=obj.copy;
        
        
        /*buffer = [NSKeyedArchiver archivedDataWithRootObject: obj.listeParticipants];
        tri.listeParticipants = [NSKeyedUnarchiver unarchiveObjectWithData: buffer];  */
        /*tri.listeParticipants=obj.listeParticipants;*/
        tri.listeParticipants=[[NSMutableArray alloc]init];
       for(int i=0;i<obj.listeParticipants.count;i++)
       {
           
        [tri.listeParticipants addObject:[obj.listeParticipants objectAtIndex:i]];
        }
        int min=0;
        int indexmin=0;
        for(int i =0;i<tri.listeParticipants.count;i++)
        {
            min=[[tri.listeParticipants objectAtIndex:i]TempsCourse1];
            Participant* minPart=[tri.listeParticipants objectAtIndex:i];
            indexmin=i;
            for(int j=i+1;j<obj.listeParticipants.count;j++)
            {
                if([[tri.listeParticipants objectAtIndex:j]TempsCourse1]<min)
                {
                    minPart=[tri.listeParticipants objectAtIndex:j];
                    indexmin=j;
                }
            }
            tri.listeParticipants[indexmin]=[tri.listeParticipants objectAtIndex:i];
            tri.listeParticipants[i]=minPart;
        }
        
        ///tri
        if(obj.listeParticipants.count<=2)
        {
            int i=0;
            for(Participant *plp in tri.listeParticipants)
            {
                /*Participant* paa = [tri.listeParticipants objectAtIndex:i];*/
                length = [[NSString stringWithFormat:@"%d",plp.No] length];
                [meilleurs appendString:[NSString stringWithFormat:@"%d",plp.No]];
                for (int j=length; j<15; j++)
                {
                    [meilleurs appendString:@" "];
                }
                length = [plp.Nom length];
                [meilleurs appendString:plp.Nom];
                for (int j=length; j<25; j++)
                {
                    [meilleurs appendString:@" "];
                }
                
                length = [plp.Prenom length];
                [meilleurs appendString:plp.Prenom];
                for (int j=length; j<25; j++)
                {
                    [meilleurs appendString:@" "];
                }
                
                length = [plp.Pays length];
                [meilleurs appendString:plp.Pays];
                for (int j=length; j<25; j++)
                {
                    [meilleurs appendString:@" "];
                }
                if(!obj.tourNo2)
                {[meilleurs appendString:[NSString stringWithFormat:@"%d secondes",plp.TempsCourse1]];
                }
                else{
                    [meilleurs appendString:[NSString stringWithFormat:@"%d secondes",plp.TempsCourse1+plp.TempsCourse2]];        }
                
                length = classement.length;
                for (int j=length; j<25; j++)
                {
                    [meilleurs appendString:@" "];
                }
                

                [meilleurs appendString:[NSString stringWithFormat:@"#%d",i+1]];
                [meilleurs appendString:@"\n"];
                i++;
            }
            
        }else{
        int compteur=0;
        for (int i=0; i < 3; i++)
        {
        Participant* paa = [tri.listeParticipants objectAtIndex:i];
            if((paa.TempsCourse1!=0 && !obj.tourNo2)||(paa.TempsCourse2!=0 && obj.tourNo2)){
            length = [[NSString stringWithFormat:@"%d",paa.No] length];
        [meilleurs appendString:[NSString stringWithFormat:@"%d",paa.No]];
        for (int j=length; j<15; j++)
        {
            [meilleurs appendString:@" "];
        }
        length = [paa.Nom length];
        [meilleurs appendString:paa.Nom];
        for (int j=length; j<25; j++)
        {
            [meilleurs appendString:@" "];
        }
        
        length = [paa.Prenom length];
        [meilleurs appendString:paa.Prenom];
        for (int j=length; j<25; j++)
        {
            [meilleurs appendString:@" "];
        }
        
        length = [paa.Pays length];
        [meilleurs appendString:paa.Pays];
        for (int j=length; j<25; j++)
        {
            [meilleurs appendString:@" "];
        }
        if(!obj.tourNo2)
        {[meilleurs appendString:[NSString stringWithFormat:@"%d secondes",paa.TempsCourse1]];
        }
        else{
            [meilleurs appendString:[NSString stringWithFormat:@"%d secondes",paa.TempsCourse1+paa.TempsCourse2]];        }
        
        length = classement.length;
        for (int j=length; j<25; j++)
        {
            [meilleurs appendString:@" "];
        }
                compteur++;
            [meilleurs appendString:[NSString stringWithFormat:@"#%d",compteur]];
            [meilleurs appendString:@"\n"];
        }else{}
        }
        }
        
        _generalRankview.text=meilleurs;
        
        if(obj.tourNo2==true&&cpt>=obj.listeParticipants.count)
        {
            NSMutableString *medaille=[NSMutableString string];
            if([[tri.listeParticipants objectAtIndex:0]TempsCourse1]+[[tri.listeParticipants objectAtIndex:0]TempsCourse2]==[[tri.listeParticipants objectAtIndex:1]TempsCourse1]+[[tri.listeParticipants objectAtIndex:1]TempsCourse2])
            {
                [medaille appendString:@"OR: "];
                [medaille appendString:[[tri.listeParticipants objectAtIndex:0]Prenom]];
                [medaille appendString:[[tri.listeParticipants objectAtIndex:0]Nom]];
                [medaille appendString:@" & "];
                [medaille appendString:[[tri.listeParticipants objectAtIndex:1]Prenom]];
                [medaille appendString:[[tri.listeParticipants objectAtIndex:1]Nom]];
                [medaille appendString:@"\nBRONZE: "];
                [medaille appendString:[[tri.listeParticipants objectAtIndex:2]Prenom]];
                [medaille appendString:[[tri.listeParticipants objectAtIndex:2]Nom]];
            }else{
            [medaille appendString:@"OR: "];
            [medaille appendString:[[tri.listeParticipants objectAtIndex:0]Prenom]];
            [medaille appendString:[[tri.listeParticipants objectAtIndex:0]Nom]];            [medaille appendString:@"\nARGENT: "];
            [medaille appendString:[[tri.listeParticipants objectAtIndex:1]Prenom]];
            [medaille appendString:[[tri.listeParticipants objectAtIndex:1]Nom]];            [medaille appendString:@"\nBRONZE: "];
            [medaille appendString:[[tri.listeParticipants objectAtIndex:2]Prenom]];
            [medaille appendString:[[tri.listeParticipants objectAtIndex:2]Nom]];
            }
            
            alert=[UIAlertController alertControllerWithTitle:@"Classement Finale!" message:medaille preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
       }
    
    //////////////////////////////////////////////////////////////
    
}

- (IBAction)penalite:(UIButton *)sender {
    
    // DataClass *obj=[DataClass getInstance];
    nbSecondePenalite = nbSecondePenalite + 30;
    
    int secondes = nbSecondePenalite % 60;
    int minutes = (nbSecondePenalite / 60) % 60;
    
    if(nbSecondePenalite >= 90){
        
        [self->lbPenalite setText: @"Disqualifié"];
        [timerButton setTitle:@"Départ" forState:UIControlStateNormal];
        [chrono invalidate], chrono = nil;
        [self sauvegarderTemps:true];
    }
    else{
        NSString* strPenalite = [NSString stringWithFormat:@"%02d:%02d",minutes,secondes];
        
        [self->lbPenalite setText: [@"+" stringByAppendingString:strPenalite]];
    }
}
- (IBAction)disqualifie:(id)sender {
    
    [self->lbPenalite setText: @"Disqualifié"];
    [timerButton setTitle:@"Départ" forState:UIControlStateNormal];
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
    Participant *p;
    if([obj.listeParticipants count]!= 0) {
        NSDate *currentDate = [NSDate date];
        NSTimeInterval secondeChrono = [currentDate timeIntervalSinceDate:debutChrono];
        NSInteger tempsChrono = secondeChrono;
        
        
        if(obj.participantEnCours >= [obj.listeParticipants  count]&&obj.tourNo2==false){
            NSMutableString *premierParticipant=[NSMutableString string];
            obj.participantEnCours = 0;
            obj.tourNo2 = true;
            premier = [obj.listeParticipants objectAtIndex:0];
            [premierParticipant appendString:@"#"];
            [premierParticipant appendString:[NSString stringWithFormat:@"%d",premier.No]];
            [premierParticipant appendString:@" "];
            [premierParticipant appendString:premier.Nom];
            [premierParticipant appendString:@" "];
            [premierParticipant appendString:premier.Prenom];
            [premierParticipant appendString:@" , "];
            [premierParticipant appendString:premier.Pays];
            [lbParticipant setText:premierParticipant];
            [lbTour setText:@"Tour #2"];
        }
    if(cpt<[obj.listeParticipants count])
    {
        p = obj.listeParticipants[cpt];
    }else
    {
        cpt=0;
        cpt2=0;
        p = obj.listeParticipants[cpt];
    }
    
        
        if(!obj.tourNo2){
            if(estDisqualifie){
                p.TempsCourse1 = -1;
                p.TempsCourse2 = -1;
                p.estDisqualifier = true;
                
            }else{
                p.TempsCourse1 =  nbSecondePenalite + (int)tempsChrono; //ajouter le temps du chrono
            }
        }else{
            if(estDisqualifie){
                p.TempsCourse1 = -1;
                p.TempsCourse2 = -1;
                p.estDisqualifier = true;
            }else
                p.TempsCourse2 = nbSecondePenalite + (int)tempsChrono; //ajouter temps chrono
        }
        
        nbSecondePenalite = 0;
        
        if(obj.participantEnCours >= [obj.listeParticipants  count] && obj.tourNo2 == true){
            //ALERT fin de la compétition
            //clear données
            [lbTour setText:@"Compétition terminée"];
            
        }
        obj.participantEnCours=obj.participantEnCours+1;
        if(obj.participantEnCours < [obj.listeParticipants  count])
        {
            NSMutableString *premierParticipant=[NSMutableString string];
        
            premier = [obj.listeParticipants objectAtIndex:obj.participantEnCours];
            while(premier.estDisqualifier == true)
            {
                if(obj.participantEnCours >= [obj.listeParticipants  count] && obj.tourNo2 == true){
                    [lbTour setText:@"Compétition terminée"];
                    break;
                }
                obj.participantEnCours=obj.participantEnCours+1;
                premier = [obj.listeParticipants objectAtIndex:obj.participantEnCours];
            }
            if (![lbTour.text isEqualToString:@"Compétition terminée"])
            {
                [premierParticipant appendString:@"#"];
                [premierParticipant appendString:[NSString stringWithFormat:@"%d",premier.No]];
                [premierParticipant appendString:@" "];
                [premierParticipant appendString:premier.Nom];
                [premierParticipant appendString:@" "];
                [premierParticipant appendString:premier.Prenom];
                [premierParticipant appendString:@" , "];
                [premierParticipant appendString:premier.Pays];
                [lbParticipant setText:premierParticipant];
            }
        }
    
    }
    
    
}


@end
