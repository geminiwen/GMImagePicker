//
//  GMImagePickerViewController.h
//  GMImagePicker
//
//  Created by 温盛章 on 16/3/23.
//  Copyright © 2016年 Gemini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class GMImagePickerController;

@protocol GMImagePickerControllerDelegate <NSObject>

@optional
- (void)gm_imagePickerController:(GMImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets;
- (void)gm_imagePickerControllerDidCancel:(GMImagePickerController *)imagePickerController;

- (BOOL)gm_imagePickerController:(GMImagePickerController *)imagePickerController shouldSelectAsset:(PHAsset *)asset;
- (void)gm_imagePickerController:(GMImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset;
- (void)gm_imagePickerController:(GMImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset;

@end

typedef NS_ENUM(NSUInteger, GMImagePickerMediaType) {
    GMImagePickerMediaTypeImage
};

@interface GMImagePickerController : UIViewController

@property (nonatomic, weak) id<GMImagePickerControllerDelegate> delegate;

@property (nonatomic, strong, readonly) NSMutableOrderedSet *selectedAssets;

@property (nonatomic, copy) NSArray *assetCollectionSubtypes;
@property (nonatomic, assign) GMImagePickerMediaType mediaType;

@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;

@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, assign) BOOL showsNumberOfSelectedAssets;

@property (nonatomic, assign) NSUInteger numberOfColumnsInPortrait;
@property (nonatomic, assign) NSUInteger numberOfColumnsInLandscape;

@end