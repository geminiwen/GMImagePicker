# GMImagePicker

Yet another image picker with photo browser. Inspired by [QBImagePicker] (https://github.com/questbeat/QBImagePicker)

![Image](http://im2.ezgif.com/tmp/ezgif-1199686347.gif)


## Example

```
GMImagePickerController *imagePickerController = [GMImagePickerController new];
imagePickerController.delegate = self;
imagePickerController.allowsMultipleSelection = YES;
imagePickerController.maximumNumberOfSelection = 6;
imagePickerController.showsNumberOfSelectedAssets = YES;

[self presentViewController:imagePickerController animated:YES completion:NULL];
```

## Delegates 

Implement `gm_imagePickerController:didFinishPickingAssets:` to get the assets selected by the user.
This method will be called when the user finishes picking assets.
```
- (void)gm_imagePickerController:(GMImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    for (PHAsset *asset in assets) {
        // Do something with the asset
    }

    [self dismissViewControllerAnimated:YES completion:NULL];
}
```

Implement `qb_imagePickerControllerDidCancel:` to get notified when the user hits "Cancel" button.

```
- (void)gm_imagePickerControllerDidCancel:(GMImagePickerController *)imagePickerController {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
```
