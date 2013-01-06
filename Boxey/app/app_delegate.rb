class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    
    initialize_metro 

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    @window.backgroundColor = UIColor.whiteColor
    @window.makeKeyAndVisible

    @blue_view = UIView.alloc.initWithFrame(CGRect.new([10,10], [@window.frame.size.width / 3 - 15,100]))
    @blue_view.backgroundColor = UIColor.blueColor

    @window.addSubview(@blue_view)

    @add_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @add_button.setTitle("Add", forState:UIControlStateNormal)
    @add_button.sizeToFit
    @add_button.frame = CGRect.new([10, @window.frame.size.height - 10 - @add_button.frame.size.height],
      @add_button.frame.size)

    @window.addSubview(@add_button)

    @add_button.addTarget(self, action:"add_tapped", forControlEvents:UIControlEventTouchUpInside)
    
    @remove_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @remove_button.setTitle("Remove", forState:UIControlStateNormal)
    @remove_button.sizeToFit
    @remove_button.frame = CGRect.new(
      [@add_button.frame.origin.x + @add_button.frame.size.width + 10, 
        @add_button.frame.origin.y], @remove_button.frame.size)
    @window.addSubview(@remove_button)
    @remove_button.addTarget(self, action:"remove_tapped", forControlEvents:UIControlEventTouchUpInside)

    true
  end

  def initialize_metro
    @metro = [
        [162,0,255],
        [255,0,151],
        [0,171,169],
        [140,191,38],
        [160,80,0],
        [230,113,184],
        [240,150,9],
        [27,161,226],
        [229,20,0],
        [51,153,51]
      ]
  end

  def remove_tapped
    other_views = @window.subviews.select {|view| not view.is_a?( UIButton )}
    @last_view = other_views.last

    if @last_view && other_views.count > 1
      index = @window.subviews.index(@last_view)
      UIView.animateWithDuration(0.5, animations:lambda {
        @last_view.alpha = 0
        @last_view.backgroundColor = UIColor.redColor
        
        other_views.each_index do |i|
          break if i == index
          other_views[i].frame = other_views[i+1].frame
        end

      },
      completion:lambda {|finished|
        @last_view.removeFromSuperview
      })
    end
  end

  def add_tapped
    new_view = UIView.alloc.initWithFrame(CGRect.new([0,0], [100,100]))
    color = @metro.sample
    new_view.backgroundColor = UIColor.alloc.initWithRed(color[0] / 255.0, green:color[1] / 255.0, 
      blue:color[2] / 255.0, alpha:1.0)
    last_view = @window.subviews.first

    x, y = last_view.frame.origin.x, last_view.frame.origin.y + last_view.frame.size.height + 10

    if y + last_view.frame.size.height >= @window.frame.size.height
      x = last_view.frame.origin.x + last_view.frame.size.width + 10
      y = @blue_view.frame.origin.y
    end

    new_view.frame = CGRect.new([x,y], last_view.frame.size)

    @window.insertSubview(new_view, atIndex:0)
  end
end
