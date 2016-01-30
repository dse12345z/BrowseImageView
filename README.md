BrowseImageView
=============
![alt tag](http://i.imgur.com/X2ItcSM.gif) 

1.use IBOutlet

     @property (weak, nonatomic) IBOutlet BrowseImageView *browseImageView;


    [self.browseImageView saveCompletion:^(UIImage *image, NSError *error, void *contextInfo) {
        // check save
    }];

2.

    BrowseImageView *browseImageView2 = [[BrowseImageView alloc] initWithFrame:frame];
    browseImageView2.image = [UIImage imageNamed:imageName];
    [browseImageView2 saveCompletion: ^(UIImage *image, NSError *error, void *contextInfo) {
        // check save
    }];
    [self.view addSubview:browseImageView2];




![alt tag](http://i.imgur.com/9N2ZLPC.gif) 

1.use IBOutlet

     @property (weak, nonatomic) IBOutlet BrowseImageView *browseImageView;


    self.browseImageView.browseImage = [UIImage imageNamed:browseImageName]; // different image
    [self.browseImageView saveCompletion:^(UIImage *image, NSError *error, void *contextInfo) {
        // check save
    }];
    
2.

    BrowseImageView *browseImageView2 = [[BrowseImageView alloc] initWithFrame:frame];
    browseImageView2.image = [UIImage imageNamed:imageName];
    browseImageView2.browseImage = [UIImage imageNamed:browseImageName]; // different image
    [browseImageView2 saveCompletion: ^(UIImage *image, NSError *error, void *contextInfo) {
        // check save
    }];
    [self.view addSubview:browseImageView2];
