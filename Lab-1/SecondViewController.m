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
}
- (IBAction)debutFin:(id)sender;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [chrono [dateByAddingTimeInterval:30]];
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
