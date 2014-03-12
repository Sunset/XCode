//
//  LoginViewController.m
//  Assignment1
//
//  Created by ahsia1 on 2/18/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    NSArray *correctSequence;
    int currentStep;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // this defines our handshake as left left up
    correctSequence = [NSArray arrayWithObjects:@"LEFT",@"LEFT",@"LEFT", nil];
    currentStep = 0;
    
    // we do 3/4 recognizers from the storyboard, we'll do the 4th here to show how it looks
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    // swipe gesture recognizers an only recognize a single direction, choose this one to be left
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    
    // we do 3/4 recognizers from the storyboard, we'll do the 4th here to show how it looks
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    // swipe gesture recognizers an only recognize a single direction, choose this one to be left
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
    
    // we do 3/4 recognizers from the storyboard, we'll do the 4th here to show how it looks
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    // swipe gesture recognizers an only recognize a single direction, choose this one to be left
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upSwipe];
    
    // we do 3/4 recognizers from the storyboard, we'll do the 4th here to show how it looks
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    // swipe gesture recognizers an only recognize a single direction, choose this one to be left
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwipe];
    
}
// all of the recognizers will call this same method
// inside of this method we determine which type of swipe occured
- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    
    
    //find out where our gesture was initialized
    CGPoint startLocation = [recognizer locationInView:self.view];
    
    //make a copy that we can change for our end location for our animation
    CGPoint endLocation = startLocation;
    
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        //remember that y increases as you move "down" the screen
        NSLog(@"up");
        endLocation.y -= 220.0;
        if([[correctSequence objectAtIndex:currentStep] isEqualToString:@"UP"])
            currentStep++;
        else
            currentStep=0;
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        //remember that y increases as you move "down" the screen
                NSLog(@"down");
        endLocation.y += 220.0;
        if([[correctSequence objectAtIndex:currentStep] isEqualToString:@"DOWN"])
            currentStep++;
        else
            currentStep=0;
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        endLocation.x -= 220.0;
                NSLog(@"left");
        if([[correctSequence objectAtIndex:currentStep] isEqualToString:@"LEFT"])
            currentStep++;
        else
            currentStep=0;
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
        endLocation.x += 220.0;
        if([[correctSequence objectAtIndex:currentStep] isEqualToString:@"RIGHT"])
            currentStep++;
        else
            currentStep=0;
    }
    else {
        NSLog(@"not a valid swipe!");
    }
    
    //once we finish running reset back to 0
    if(currentStep == correctSequence.count)
    {
        [self performSegueWithIdentifier:@"ToView" sender:self];
        currentStep=0;
    }
    
}

/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"ToView"])
    {
        [segue.destinationViewController];
    }
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
