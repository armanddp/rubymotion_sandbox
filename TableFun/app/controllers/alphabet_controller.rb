class AlphabetController < UIViewController
  def viewDidLoad
    super
    self.title = "Alphabet"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    self.view.addSubview(@table)
    
    @table.dataSource = self
    @table.delegate = self
    
    @data = {}
    ("A".."Z").to_a.each do |letter|
      @data[letter] = []
      5.times {@data[letter] << letter + rand(100).to_s}
    end
  end

  # TableView dataSource Implementation

  # return the number of rows
  def tableView(tableView, numberOfRowsInSection: section)
    rows_for_section(section).count
  end

  # return the UITableViewCell for the row
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_ID"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||=  UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell.textLabel.text = row_for_index_path(indexPath)
    cell
  end

  # UITableView delegate methods
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated:true)
    letter = sections[indexPath.section]

    controller = UIViewController.alloc.initWithNibName(nil, bundle:nil)
    controller.view.backgroundColor = UIColor.whiteColor
    controller.title = letter
    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = row_for_index_path(indexPath)
    label.sizeToFit
    label.center = [controller.view.frame.size.width / 2, 
      controller.view.frame.size.height / 2]
    controller.view.addSubview(label)
    self.navigationController.pushViewController(controller, animated:true)
  end

  def tableView(tableView, titleForHeaderInSection: section)
    sections[section]
  end

  # Datasource methods
  def sections
    @data.keys.sort
  end

  def rows_for_section(section_index)
    @data[self.sections[section_index]]
  end

  def row_for_index_path(index_path)
    rows_for_section(index_path.section)[index_path.row]
  end

  def numberOfSectionsInTableView(tableView)
    self.sections.count
  end


end