//
//  ViewController.m
//  Assignment1
//
//  Created by ahsia1 on 1/28/14.
//  Copyright (c) 2014 ahsia1. All rights reserved.
//

#import "ViewController.h"
#import "Bank Account Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.convert_count = 0;
    self.exchangeRates = 1;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
 
    [self updateLabel];
    [self downloadExample];
    
    
}
-(void)updateLabel
{
    self.BalanceLabel.text=[NSString stringWithFormat:@"Balance: %.2f", (self.BAM.balance * [_BAM getRate])];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//CREATING THE INSTANCE OF THE OBJECT. SIMILAR TO CREATING A CONSTRUCTOR IN JAVA/C++
-(Bank_Account_Model *)BAM
{
    //if we aren't pointing to an object then make it
    if(_BAM == Nil)
    {
        _BAM = [[Bank_Account_Model alloc] init];
    }
    return _BAM;
}
-(void)downloadExample
{   //*keys contains the key in the dictionary
    //http://openexchangerates.org/api/latest.json?app_id=d812aa870eda4ae8863a305a504a21bc
    // here is our prebuilt URL string which will retrieve data
    NSData *ourData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://openexchangerates.org/api/latest.json?app_id=d812aa870eda4ae8863a305a504a21bc"]];
    
    NSString *List = [[NSBundle mainBundle] pathForResource:@"ConversionList" ofType:@"plist"];
    self.countrylist = [NSMutableArray arrayWithContentsOfFile:List];
    
    NSDictionary *ourDict = [NSJSONSerialization JSONObjectWithData:ourData options:kNilOptions error:Nil];

    self.recipes = ourDict[@"rates"];
    self.keys = [self.recipes allKeys];
	// values in foreach loop
	for (NSString *key in self.keys) {
		//NSLog(@"%@ is %@",key, [self.recipes objectForKey:key]);
       
	}

    // this list will store our recipe objects after they are parsed
    //self.recipes = [[NSMutableDictionary alloc] init];
    
    // step through each of our recipe objects(in Dictionary form)
    // and parse them into a RecipeModel object (with known structure)
    // for ( NSDictionary *recipe in ourDict[@"rates"])
    // {
    //    [self.recipes addObject:[[RecipeModel alloc] initWithDict:recipe]];
    //}
    
    ///simple print to show us that the operation was successful
    //NSLog(@"%@",self.recipes);
    
    //tell our tableview that we have updated the data
    //[self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"SegueToList"])
    {
        TransactionViewController *nextVC = segue.destinationViewController;
        nextVC.model = self.BAM;
        self.convert_count = 0;

    }
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.keys.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.keys objectAtIndex:row];
}
-(void)updateCountry:(NSString*)CLabel;
{
    self.CountryLabel.text = CLabel;
}
-(IBAction)Convert:(id)sender{

        int index = [self.Picker selectedRowInComponent:0];
        // NSString *selectedCountry = [self.recipes objectAtIndex:index];
    id akey = [self.keys objectAtIndex:index];
    NSString *selectedCountryRate =[self.recipes objectForKey:akey];
    NSLog(@"%@ here %@ and %@",self.recipes, self.keys, [self.recipes objectForKey:akey]);
    self.exchangeRates = [selectedCountryRate doubleValue];
    [_BAM setRate: self.exchangeRates];
    [_BAM saveChecklistItems];
    if(self.convert_count==0){
        [self updateLabel];
        [self updateCountry:[self.keys objectAtIndex:index]];
        self.convert_count = 1;
    }
    else
    {
        [self updateLabel];
        [self updateCountry:[self.keys objectAtIndex:index]];
    }
    
}

- (IBAction)deposit:(id)sender {
    [_amount resignFirstResponder];
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    
    //NSString *newBalance = [NSString stringWithFormat:@"%.2f", (self.amount.text.doubleValue/self.exchangeRates)];
    NSString *newBalance = [NSString stringWithFormat:@"%.2f", (self.amount.text.doubleValue/[_BAM getRate])];
    //self.BAM.balance += (self.amount.text.doubleValue/self.exchangeRates);
    self.BAM.balance += [newBalance doubleValue];
    [self.BAM insertName:[NSString stringWithFormat:@"Deposited: $%.2f at this time: %@", self.amount.text.doubleValue, newDateString]];
    
    NSLog(@"%.2f", self.BAM.balance);
    [self updateLabel];
}

- (IBAction)withdraw:(id)sender {
    [_amount resignFirstResponder];
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    
    NSString *newBalance = [NSString stringWithFormat:@"%.2f", (self.amount.text.doubleValue/[_BAM getRate])];
    
    if([newBalance doubleValue]>self.BAM.balance)
    {
        [self.BAM insertName:[NSString stringWithFormat:@"You do not have sufficient funds"]];
    }
    else
    {
        self.BAM.balance -= [newBalance doubleValue];
        [self.BAM insertName:[NSString stringWithFormat:@"Withdrawn: $%.2f at this time: %@", self.amount.text.doubleValue, newDateString]];
        NSString *newBalance1 = [NSString stringWithFormat:@"%.2f", self.BAM.balance];
        self.BAM.balance = [newBalance1 doubleValue];
        NSLog(@"%.2f", self.BAM.balance);
        [self updateLabel];
    }
}
@end
