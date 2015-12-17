//
//  AppointmentViewController.m
//  Fashionistas
//
//  Created by YangYusheng on 12/9/15.
//  Copyright © 2015 sm. All rights reserved.
//

#import "AppointmentViewController.h"
#import <BFPaperButton/BFPaperButton.h>
#import <UIColor+BFPaperColors/UIColor+BFPaperColors.h>
#import "Config.h"

@interface AppointmentViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *dateAndTimeFirstPriorityTextField;
@property (strong, nonatomic) IBOutlet UITextField *serviceTypeTextField;

@property (strong,nonatomic) NSArray *theData;
@property (nonatomic, strong) UIDatePicker *myDatePicker;

@property (strong, nonatomic) IBOutlet BFPaperButton *submitButton;


@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Appointment";
    
    if ([Config isLogedIn]) {
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        self.nameTextField.text = [settings objectForKey:@"username"];
        self.emailAddressTextField.text = [settings objectForKey:@"email"];
    }
    
    self.myDatePicker = [[UIDatePicker alloc]init];
    self.myDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.dateAndTimeFirstPriorityTextField setInputView:self.myDatePicker];
    
    UIToolbar *datePickerToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [datePickerToolBar setTintColor:[UIColor greenColor]];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(displaySelectDate)];
    UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [datePickerToolBar setItems:@[spaceBtn,doneBtn]];
    [self.dateAndTimeFirstPriorityTextField setInputAccessoryView:datePickerToolBar];
    
    //init the submit button
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    self.submitButton.backgroundColor = [UIColor paperColorYellow700];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.submitButton.isRaised = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)MakeAppointmentButtonClick:(id)sender{
    NSString *username = self.nameTextField.text;
    NSString *emailAddress = self.emailAddressTextField.text;
    NSString *phoneNumber = self.phoneNumberTextField.text;
    NSString *dateTime = self.dateAndTimeFirstPriorityTextField.text;
    NSString *service = self.serviceTypeTextField.text;
    NSString *mailContent = [NSString stringWithFormat:@"<!DOCTYPE html><html><body><p>Dear Fashionastic Designer:</p><p>I would like to make an appointment to have a %@ service. My available date and time is %@. </br>My phone number is: %@.</br>My Emial address  is %@.</br>If you need more information, Please contact me!</p><p>%@</br>Best Regards</p></body></html>", service,dateTime,phoneNumber,emailAddress,username];
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
        mc.mailComposeDelegate = self;
        [mc setSubject:[NSString stringWithFormat:@"%@ %@ appointment", username, service]];
        [mc setTitle:@"Appointment"];
        [mc setMessageBody:mailContent isHTML:YES];
        
        [mc setToRecipients:@[@"fashionistas.salon@comcast.net"]];        [self presentViewController:mc animated:YES completion:NULL];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)displaySelectDate
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
    [dateFormater setDateFormat:@"dd/mm/yyyy 'at' HH:mm"];
    self.dateAndTimeFirstPriorityTextField.text = [NSString stringWithFormat:@"%@",[dateFormater stringFromDate:self.myDatePicker.date]];
    [self.dateAndTimeFirstPriorityTextField resignFirstResponder];
}

@end



















