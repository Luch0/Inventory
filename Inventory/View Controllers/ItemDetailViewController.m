//
//  ItemDetailViewController.m
//  Inventory
//
//  Created by Luis Calle on 9/1/18.
//  Copyright © 2018 Lucho. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ImageStore.h"

@interface ItemDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemValueTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateCreatedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@property (nonatomic) ImageStore *imageStore;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _itemNameTextField.delegate = self;
    _serialNumberTextField.delegate = self;
    _itemValueTextField.delegate = self;
    self.navigationItem.title = @"Item";
    [self setItem];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
//    if (!_itemNameTextField.text) _item.name = _itemNameTextField.text;
//    else _item.name = @"";
    
    _item.name = _itemNameTextField.text;
    _item.serialNumber = _serialNumberTextField.text;
    _item.valueInDollars = [self formatValueFromString:_itemValueTextField.text];
    
//    if (!_itemValueTextField.text) {
//        _item.valueInDollars = [self formatValueFromString:_itemNameTextField.text];
//    } else _item.valueInDollars = 0;
}

- (void) setItem {
    if (!_item.name) _itemNameTextField.text = @"No Item Name";
    else _itemNameTextField.text = _item.name;
    
    if (!_item.serialNumber) _serialNumberTextField.text = @"No Serial Number";
    else _serialNumberTextField.text = _item.serialNumber;
    
    if (!_item.valueInDollars) _itemValueTextField.text = @"No Value";
    else _itemValueTextField.text = [self formatValueFromNumber:_item.valueInDollars];
    
    if (!_item.dateCreated) _dateCreatedLabel.text = @"No Date Available";
    else _dateCreatedLabel.text = [self formatDate:_item.dateCreated];
    
    UIImage *itemImage = [_imageStore imageForKey:_item.itemKey];
    _itemImageView.image = itemImage;
}

- (NSString*)formatValueFromNumber:(NSNumber*)value {
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    nf.minimumFractionDigits = 2;
    nf.maximumFractionDigits = 2;
    return [nf stringFromNumber:value];
}

- (NSNumber*)formatValueFromString:(NSString*)value {
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    nf.minimumFractionDigits = 2;
    nf.maximumFractionDigits = 2;
    return [nf numberFromString:value];
}

- (NSString*)formatDate:(NSDate*)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    df.timeStyle = NSDateFormatterNoStyle;
    return [df stringFromDate:date];
}

- (void)setImageStore:(ImageStore*)imageStore {
    _imageStore = imageStore;
}

- (IBAction)backgroundTapped:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)takePicture:(UIBarButtonItem *)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark UIImagePickerControllerDelegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = (UIImage*) info[UIImagePickerControllerOriginalImage];
    
    [_imageStore setImage:image forKey:_item.itemKey];
    
    _itemImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
