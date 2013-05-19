

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.noFileImageView.hidden = YES;
    
    [self refresh];
}



- (IBAction)selectedFile:(UIButton *)senderButton {

    iPressBookFile *aniPressBookFile = (iPressBookFile *)[senderButton titleForState:UIControlStateApplication];
    
    NSString *localFilePath = [aniPressBookFile localFilePath];

    if (nil == localFilePath) {
        NSLog(@"Nil local file path");
        return;
    }
    
    NSURL *localFilePathURL = [NSURL fileURLWithPath:localFilePath];

    
    NSLog(@"local file path: %@", localFilePath);
    
    NSString *fileExtension = [[[aniPressBookFile fileName] pathExtension] lowercaseString];
    
    NSLog(@"file extension : %@", fileExtension);
    
    
    // Picture
    if ([[NSArray arrayWithObjects:@"png", @"jpg", @"gif", @"jpeg", nil] containsObject:fileExtension]) {
        PictureViewController *pictureViewController = [[PictureViewController alloc] init];
        
        
        
        [self presentModalViewController:pictureViewController animated:YES];
        [pictureViewController.fileImageView setImageWithURL:localFilePathURL placeholderImage:[UIImage imageNamed:@"default-picture.png"]];
        [pictureViewController release];
        
        return;
    }
    
    // Movie
    if ([[NSArray arrayWithObjects:@"mov", @"m4v", @"mpv", @"3gp", @"mp4", @"mpv",
          nil] containsObject:fileExtension]) {
        NSLog(@"Opening a movie : %@", localFilePath);
        VideosViewController *videosViewController = [[VideosViewController alloc] init];

        [self presentModalViewController:videosViewController animated:YES];
        [videosViewController startPlayingVideoAtPath:localFilePath];
        
        [videosViewController release];
        
        return;
    }
    

    