class ColorsController < UIViewController

  include Metro

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.blackColor

    @label = UILabel.alloc.initWithFrame(CGRectZero)
    @label.text = "Colors"
    @label.sizeToFit
    @label.textColor = UIColor.whiteColor
    @label.backgroundColor = UIColor.blackColor
    @label.center = [self.view.frame.size.width / 2, 
      self.view.frame.size.height / 2]
    @label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
      UIViewAutoresizingFlexibleTopMargin

    self.view.addSubview(@label)
    self.title = "Colors"

    setup_color_buttons
  end

  def setup_color_buttons
    metro_colors.each_with_index do |color, index|
      color = UIColor.alloc.initWithRed(color[0] / 255.0, green:color[1] / 255.0, 
        blue:color[2] / 255.0, alpha:1.0)

      button_width = (self.view.frame.size.width / 5) - 5
      button = UIButton.buttonWithType(UIButtonTypeCustom)
      button.setBackgroundColor(color)
      
      y = @label.frame.origin.y + button.frame.size.height + 50
      if index > 4
        y += (button.frame.size.height + 50 + 20) 
        x = (index - 5) * button_width + 20
      else
        x = index * button_width + 20
      end

      button.frame = [
        [x, y],
        [button_width - 10, button_width - 10]
      ]
      button.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleTopMargin

      button.tag = index
      button.addTarget(self, action:"tapped_color:",
        forControlEvents:UIControlEventTouchUpInside)
      self.view.addSubview(button)
    end
  end

  def tapped_color(sender)
    color = metro_colors[sender.tag]
    color = UIColor.alloc.initWithRed(color[0]/255.0, green:color[1]/255.0, 
      blue:color[2]/255.0, alpha:1.0)
    controller = ColorDetailController.alloc.initWithColor(color)
    self.navigationController.pushViewController(controller, animated:true)
  end

  # Don't think method_missing invoked, for now just doing the tags
  def method_missing(meth, *args, &block)
    puts "METHOD MISSING #{meth}"
    if meth.to_s =~ /^tap_(\d+)$/
      tap_color($1)
    else
      super
    end
  end

  def tap_color(color)
    puts "Color Tapped #{color}"
  end

end