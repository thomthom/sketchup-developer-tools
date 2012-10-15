# Copyright:: Copyright 2012 Trimble Navigation Ltd.
# License:: Apache License version 2.0
# Original Author:: Scott Lininger 
#
# Tests the SketchUp Ruby API BoundingBox object.
#
# This file was originally generated by ourdoc.rb, an internal tool we developed
# specifically for outputting support files (documentation, unit tests, etc.)
# from the standard, doxygen-style c++ comments that are embedded into the
# Ruby implementation files. You can find ourdoc.rb alongside these
# implementation files at:
#
# googleclient/sketchup/source/sketchup/ruby
#

require 'test/unit'

# TC_BoundingBox contains unit tests for the BoundingBox class.
#
# API Object::       BoundingBox
# C++ File::         rboundingbox.cpp
# Parent Class::     Object
# Version::          SketchUp 6.0
#
# Bounding boxes are three-dimensional boxes (eight corners), aligned with the
# global axes, that surrounds entities within your model. There is a default
# bounding box for any new (empty) model that will surround all entities,
# including all groups and components, in your model. Additionally, there are
# bounding boxes for all components and groups (which can be seen when
# selecting the component or groups). Bounding boxes are only large enough to
# exactly bound the entities within your model, group, or component.
# The
# BoundingBox class is used to create and manipulate a new bounding box.
#
#
class TC_BoundingBox < Test::Unit::TestCase

  # Setup for test cases, if required.
  #
  def setup
    def UI::messagebox(params)
      puts 'TESTUP OVERRIDE: UI::messagebox > ' + params.to_s
    end
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.max
  # @file                rboundingbox.cpp
  #
  # The max method is used to retrieve the Point3d object where x, y and z
  # are maximum in the bounding box.
  #
  # If you attempt to call the max method on an empty bounding box, you
  # will receive a very large negative number.
  #
  #
  # Args:
  #
  # Returns:
  # - point: a Point3d object representing the point where
  # x, y, and z are the maximum in the bounding box.
  #

  # Test the example code that we have in the API documentation.
  def test_max_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     bbox = model.bounds
     point1 = Geom::Point3d.new(100, 200, 300)
     point2 = Geom::Point3d.new(300, 200, 100)
     bbox = bbox.add point1
     bbox = bbox.add point2
     point = bbox.max
     UI.messagebox(point.to_s)
    end
  end

  # Test edgecases for values passed to this method.
  def test_max_edgecases
    point = nil
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox.add [0,0,0]
     bbox.add [100,100,100]
     point = bbox.max
    end
    expected_point = Geom::Point3d.new 100,100,100
    assert_equal(expected_point, point,
                 'Failed in test_max_edgecases: positive point' )

    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox.add [-10,-10,-10]
     bbox.add [-100,-100,-100]
     point = bbox.max
    end
    expected_point = Geom::Point3d.new -10,-10,-10
    assert_equal(expected_point, point,
                 'Failed in test_max_edgecases: negative point' )
    
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     point = bbox.max
    end
    # Empty boxes should return very large negative numbers
    x_very_small = point.x < -1000000000000000000000000
    y_very_small = point.y < -1000000000000000000000000
    z_very_small = point.z < -1000000000000000000000000
    assert_equal(true, x_very_small,
                 'Failed in test_max_edgecases: empty bb x' )
    assert_equal(true, y_very_small,
                 'Failed in test_max_edgecases: empty bb y' )
    assert_equal(true, z_very_small,
                 'Failed in test_max_edgecases: empty bb z' )
  end


  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.intersect
  # @file                rboundingbox.cpp
  #
  # The intersect method is used to retrieve a bounding box that is the
  # result of intersecting one bounding box with another.
  #
  # Adding one point to an empty bounding box, does not increase the size
  # of the bounding box. You must add at least two points before methods,
  # such as BoundingBox.diagonal, will return a size greater than zero.
  #
  #
  # Args:
  # - boundingbox2: A second boundbox which might intersect boundingbox1.
  #
  # Returns:
  # - boundingbox: the resulting BoundingBox object if
  # successful, an empty BoundingBox object if
  # unsuccessful.
  #

  # Test the example code that we have in the API documentation.
  def test_intersect_api_example
    boundingbox = nil
    assert_nothing_raised do
     boundingbox1 = Geom::BoundingBox.new
     boundingbox1.add [0,0,0]
     boundingbox1.add [100,100,100]
     boundingbox2 = Geom::BoundingBox.new
     boundingbox2.add [50,50,50]
     boundingbox2.add [150,150,150]
     boundingbox = boundingbox1.intersect boundingbox2
    end
    expected_w = 50
    expected_h = 50
    expected_d = 50

    assert_equal(expected_h, boundingbox.height,
                 'Failed in test_intersect' )
    assert_equal(expected_w, boundingbox.width,
                 'Failed in test_intersect' )
    assert_equal(expected_d, boundingbox.depth,
                 'Failed in test_intersect' )
  end

  def test_intersect_no_overlap
    boundingbox = nil
    assert_nothing_raised do
     boundingbox1 = Geom::BoundingBox.new
     boundingbox1.add [0,0,0]
     boundingbox1.add [100,100,100]
     boundingbox2 = Geom::BoundingBox.new
     boundingbox2.add [150,150,150]
     boundingbox2.add [250,250,250]
     boundingbox = boundingbox1.intersect boundingbox2
    end
    expected_w = 0
    expected_h = 0
    expected_d = 0

    assert_equal(expected_h, boundingbox.height,
                 'Failed in test_intersect_no_overlap: w' )
    assert_equal(expected_w, boundingbox.width,
                 'Failed in test_intersect_no_overlap: h' )
    assert_equal(expected_d, boundingbox.depth,
                 'Failed in test_intersect_no_overlap: d' )
    assert_equal(false, boundingbox.valid?,
                 'Failed in test_intersect_no_overlap: valid?' )
  end



  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.height
  # @file                rboundingbox.cpp
  #
  # The height method is used to retrieve the height of the bounding box.
  #
  # The height is returned in the currently set units (inches, by
  # default).
  #
  #
  # Args:
  #
  # Returns:
  # - height: the height of the bounding box
  #

  # Test the example code that we have in the API documentation.
  def test_height_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     bbox = model.bounds
     point1 = Geom::Point3d.new(100, 200, 300)
     point2 = Geom::Point3d.new(300, 200, 100)
     bbox = bbox.add point1
     bbox = bbox.add point2
     UI.messagebox(bbox.height)
    end
  end

  # Test some controlled BBs.
  def test_height_simple
    bbox = nil
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox = bbox.add [100,100,100]
     bbox = bbox.add [200,200,200]
    end
    assert_equal(100, bbox.height,
                 'Failed in test_height_simple' )
  end

  # Test a zero-height BB. NOTE that for some reason the API thinks of
  # BB height as being along the Y Axis instead of the Z. Even though I think
  # personally that this is broken, we're talking about a legacy behavior
  # that we can't change without expecting to break end-user scripts, so
  # I'm writing tests against the "as-is" functionality. - scottlininger
  def test_height_zero
    bbox = nil
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox = bbox.add [100,100,100]
     bbox = bbox.add [200,100,200]
    end
    assert_equal(0, bbox.height,
                 'Failed in test_height_zero' )
  end


  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.valid?
  # @file                rboundingbox.cpp
  #
  # The valid method is used to determine if a bounding box is valid
  # (contains points).
  #
  #
  # Args:
  #
  # Returns:
  # - status: true if the bounding box is valid (not empty),
  # false if it is not valid (empty)
  #

  # Test the example code that we have in the API documentation.
  def test_valid_api_example
    assert_nothing_raised do
     bbox = Sketchup.active_model.bounds
     status = bbox.valid?
     if (status)
       # If true, bounding box is empty.
     else
       # If false, bounding box contains entities.
     end
    end
  end

  # Test common cases
  def test_valid_when_empty
    bbox = Geom::BoundingBox.new
    status = bbox.valid?
    assert_equal(false, status,
                 'Failed in test_valid_when_empty' )
  end

  def test_valid_when_one_point
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    status = bbox.valid?
    assert_equal(true, status,
                 'Failed in test_valid_when_one_point' )
  end

  def test_valid_when_1d_along_x
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [10,0,0]
    status = bbox.valid?
    assert_equal(true, status,
                 'Failed in test_valid_when_1d_along_x' )
  end

  def test_valid_when_1d_along_y
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [0,10,0]
    status = bbox.valid?
    assert_equal(true, status,
                 'Failed in test_valid_when_1d_along_y' )
  end

  def test_valid_when_1d_along_z
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [0,0,10]
    status = bbox.valid?
    assert_equal(true, status,
                 'Failed in test_valid_when_1d_along_z' )
  end

  def test_valid_when_2d_along_xy
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [10,10,0]
    status = bbox.valid?
    assert_equal(true, status,
                 'Failed in test_valid_when_2d_along_xy' )
  end

  def test_valid_when_2d_along_yz
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [0,10,10]
    status = bbox.valid?
    assert_equal(true, status,
                 'Failed in test_valid_when_2d_along_yz' )
  end

  def test_valid_when_2d_along_xz
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [10,0,10]
    status = bbox.valid?
    assert_equal(true, status,
                 'Failed in test_valid_when_2d_along_xz' )
  end


  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.empty?
  # @file                rboundingbox.cpp
  #
  # The empty? method is used to determine if a bounding box is empty
  # (such as if the bounds have not been set.)
  #
  #
  # Args:
  #
  # Returns:
  # - status: true if the bounding box is empty, false if it
  # is not empty
  #

  # Test the example code that we have in the API documentation.
  def test_empty_api_example
    assert_nothing_raised do
     bbox = Sketchup.active_model.bounds
     status = bbox.empty?
     if (status)
       # If true, bounding box is empty.
     else
       # If false, bounding box contains entities.
     end
    end
  end

    # Test common cases
  def test_empty_when_empty
    bbox = Geom::BoundingBox.new
    status = bbox.empty?
    assert_equal(true, status,
                 'Failed in test_empty_when_empty' )
  end

  def test_empty_when_one_point
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    status = bbox.empty?
    assert_equal(false, status,
                 'Failed in test_empty_when_one_point' )
  end

  def test_empty_when_1d_along_x
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [10,0,0]
    status = bbox.empty?
    assert_equal(false, status,
                 'Failed in test_empty_when_1d_along_x' )
  end

  def test_empty_when_1d_along_y
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [0,10,0]
    status = bbox.empty?
    assert_equal(false, status,
                 'Failed in test_empty_when_1d_along_y' )
  end

  def test_empty_when_1d_along_z
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [0,0,10]
    status = bbox.empty?
    assert_equal(false, status,
                 'Failed in test_empty_when_1d_along_z' )
  end

  def test_empty_when_2d_along_xy
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [10,10,0]
    status = bbox.empty?
    assert_equal(false, status,
                 'Failed in test_empty_when_2d_along_xy' )
  end

  def test_empty_when_2d_along_yz
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [0,10,10]
    status = bbox.empty?
    assert_equal(false, status,
                 'Failed in test_empty_when_2d_along_yz' )
  end

  def test_empty_when_2d_along_xz
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [10,0,10]
    status = bbox.empty?
    assert_equal(false, status,
                 'Failed in test_empty_when_2d_along_xz' )
  end


  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.min
  # @file                rboundingbox.cpp
  #
  # The min method is used to retrieve the Point3d where x, y and z are
  # minimum in the bounding box.
  #
  #
  # Args:
  #
  # Returns:
  # - point: a Point3d object representing the point where
  # x, y, and z are the maximum in the bounding box.
  #

  # Test the example code that we have in the API documentation.
  def test_min_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     bbox = model.bounds
     point1 = Geom::Point3d.new(100, 200, 300)
     point2 = Geom::Point3d.new(300, 200, 100)
     bbox = bbox.add point1
     bbox = bbox.add point2
     point = bbox.min
     UI.messagebox(point.to_s)
    end
  end

    # Test edgecases for values passed to this method.
  def test_min_edgecases
    point = nil
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox.add [0,0,0]
     bbox.add [100,100,100]
     point = bbox.min
    end
    expected_point = Geom::Point3d.new 0,0,0
    assert_equal(expected_point, point,
                 'Failed in test_min_edgecases: positive point' )

    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox.add [-10,-10,-10]
     bbox.add [-100,-100,-100]
     point = bbox.min
    end
    expected_point = Geom::Point3d.new -100,-100,-100
    assert_equal(expected_point, point,
                 'Failed in test_min_edgecases: negative point' )
    
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     point = bbox.min
    end
    # Empty boxes should return very large positive numbers
    x_very_small = point.x > 1000000000000000000000000
    y_very_small = point.y > 1000000000000000000000000
    z_very_small = point.z > 1000000000000000000000000
    assert_equal(true, x_very_small,
                 'Failed in test_min_edgecases: empty bb x' )
    assert_equal(true, y_very_small,
                 'Failed in test_min_edgecases: empty bb y' )
    assert_equal(true, z_very_small,
                 'Failed in test_min_edgecases: empty bb z' )
  end




  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.corner
  # @file                rboundingbox.cpp
  #
  # The corner method is used to retrieve a point object at a specified
  # corner of the bounding box.
  #
  # There are 8 corners to a bounding box, identified by the numbers 0
  # through 7. Points are returned in the currently set units (inches, by
  # default).
  #
  #
  # Args:
  # - corner: A number (from 0 to 7) representing point at the corner you
  # want to retrieve.
  #
  # Returns:
  # - point: a Point3d object if successful
  #

  # Test the example code that we have in the API documentation.
  def test_corner_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     bbox = model.bounds
     point1 = Geom::Point3d.new(100, 200, 300)
     point2 = Geom::Point3d.new(300, 200, 100)
     bbox = bbox.add point1
     bbox = bbox.add point2
     UI.messagebox(bbox.corner(0))
    end
  end

  def test_corner_all

    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [1,1,1]

    p0 = Geom::Point3d.new 0, 0, 0 # (left front bottom) 
    p1 = Geom::Point3d.new 1, 0, 0 # (right front bottom) 
    p2 = Geom::Point3d.new 0, 1, 0 # (left back bottom) 
    p3 = Geom::Point3d.new 1, 1, 0 # (right back bottom) 
    p4 = Geom::Point3d.new 0, 0, 1 # (left front top) 
    p5 = Geom::Point3d.new 1, 0, 1 # (right front top) 
    p6 = Geom::Point3d.new 0, 1, 1 # (left back top) 
    p7 = Geom::Point3d.new 1, 1, 1 # (right back top)

    assert_equal(p0, bbox.corner(0), 'Failed in test_corner_all: 0')
    assert_equal(p1, bbox.corner(1), 'Failed in test_corner_all: 1')
    assert_equal(p2, bbox.corner(2), 'Failed in test_corner_all: 2')
    assert_equal(p3, bbox.corner(3), 'Failed in test_corner_all: 3')
    assert_equal(p4, bbox.corner(4), 'Failed in test_corner_all: 4')
    assert_equal(p5, bbox.corner(5), 'Failed in test_corner_all: 5')
    assert_equal(p6, bbox.corner(6), 'Failed in test_corner_all: 6')
    assert_equal(p7, bbox.corner(7), 'Failed in test_corner_all: 7')

  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.depth
  # @file                rboundingbox.cpp
  #
  # The depth method is used to retrieve the depth of the bounding box.
  #
  # The depth is returned in the currently set units (inches, by
  # default).
  #
  #
  # Args:
  #
  # Returns:
  # - depth: the depth of the bounding box if successful
  #

  # Test the example code that we have in the API documentation.
  def test_depth_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     bbox = model.bounds
     point1 = Geom::Point3d.new(100, 200, 300)
     point2 = Geom::Point3d.new(300, 200, 100)
     bbox = bbox.add point1
     bbox = bbox.add point2
     UI.messagebox(bbox.depth)
    end
  end

  # Test some controlled BBs.
  def test_depth_simple
    bbox = nil
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox = bbox.add [100,100,100]
     bbox = bbox.add [200,200,200]
    end
    assert_equal(100, bbox.depth,
                 'Failed in test_depth_simple' )
  end

  # Test a zero-depth BB. NOTE that for some reason the API thinks of
  # BB depth as being along the Z Axis instead of the Y. Even though I think
  # personally that this is broken, we're talking about a legacy behavior
  # that we can't change without expecting to break end-user scripts, so
  # I'm writing tests against the "as-is" functionality. - scottlininger
  def test_depth_zero
    bbox = nil
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox = bbox.add [100,100,100]
     bbox = bbox.add [200,200,100]
    end
    assert_equal(0, bbox.depth,
                 'Failed in test_depth_zero' )
  end


  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.clear
  # @file                rboundingbox.cpp
  #
  # The clear method is used to clear a bounding box.
  #
  # A cleared BoundingBox does not have a size greater than zero until
  # you add at least two points or another bounding box.
  #
  #
  # Args:
  #
  # Returns:
  # - boundingbox: the BoundingBox object which was cleared
  #

  # Test the example code that we have in the API documentation.
  def test_clear_api_example
    assert_nothing_raised do
      bbox = Geom::BoundingBox.new
      bbox.add [0,0,0]
      bbox.add [100,100,100]
      UI.messagebox("before clear, bounding box empty? " + bbox.empty?.to_s)
      bbox.clear
      UI.messagebox("after clear, bounding box empty? " + bbox.empty?.to_s)
    end
  end

  # Test basic usage.
  def test_clear_simple
    bbox = Geom::BoundingBox.new
    bbox.add [0,0,0]
    bbox.add [100,100,100]
    assert_equal(false, bbox.empty?,
                 'Failed in test_clear_simple: Should not be empty.')
    bbox.clear
    assert_equal(true, bbox.empty?,
                 'Failed in test_clear_simple: Should be empty after clear.')
  end

  # Test that nothing is raised when a clear bounding box is cleared.
  def test_clear_already_empty
    assert_nothing_raised do 
      bbox = Geom::BoundingBox.new
      bbox.clear
    end
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.contains?
  # @file                rboundingbox.cpp
  #
  # This method is used to determine if a bounding box contains a specific
  # Point3d or BoundingBox object.
  #
  #
  # Args:
  # - point: A Point3d object.
  # - boundbox: A BoundingBox object.
  #
  # Returns:
  # - status: true if successful (bounding box contains a
  # Point3d or BoundingBox object), or false if
  # unsuccessful.
  #

  # Test the example code that we have in the API documentation.
  def test_contains_api_example
    status = nil
    assert_nothing_raised do
     point = Geom::Point3d.new(100,200,300)
     bbox = Sketchup.active_model.bounds
     bbox.add point
     # should return true
     status = bbox.contains? point
    end
    assert_equal(true, status,
                 'Failed in test_contains' )
  end

  # Test a series of points that should report as being contained.
  def test_contains_point_true

    bbox = Geom::BoundingBox.new
    bbox.add Geom::Point3d.new(0,0,0)
    bbox.add Geom::Point3d.new(10,10,10)

    point = Geom::Point3d.new(5,5,5)
    assert_equal(true, bbox.contains?(point),
                 'Failed in test_contains_point_true: center' )

    point = Geom::Point3d.new(0,0,0)
    assert_equal(true, bbox.contains?(point),
                 'Failed in test_contains_point_true: min' )

    point = Geom::Point3d.new(10,10,10)
    assert_equal(true, bbox.contains?(point),
                 'Failed in test_contains_point_true: max' )
  end

  # Test a series of points that should not report as being contained.
  def test_contains_point_false

    bbox = Geom::BoundingBox.new
    bbox.add Geom::Point3d.new(0,0,0)
    bbox.add Geom::Point3d.new(10,10,10)

    point = Geom::Point3d.new(15,15,15)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: greater' )

    point = Geom::Point3d.new(-10,-10,-10)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: lessthan' )

    point = Geom::Point3d.new(5,5,-10)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed1' )

    point = Geom::Point3d.new(5,-10,5)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed3' )

    point = Geom::Point3d.new(5,5,-10)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed3' )

    point = Geom::Point3d.new(-10,5,-10)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed4' )

    point = Geom::Point3d.new(-10,-10,5)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed5' )

    point = Geom::Point3d.new(-10,5,-10)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed6' )


    point = Geom::Point3d.new(15,5,15)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed7' )

    point = Geom::Point3d.new(15,15,5)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed8' )

    point = Geom::Point3d.new(15,5,15)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed9' )

    point = Geom::Point3d.new(5,5,-10)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed10' )

    point = Geom::Point3d.new(5,-10,5)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed11' )

    point = Geom::Point3d.new(5,5,-10)
    assert_equal(false, bbox.contains?(point),
                 'Failed in test_contains_point_false: mixed12' )
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.new
  # @file                rboundingbox.cpp
  #
  # The new method is used to create a new, empty, bounding box.
  #
  #
  # Args:
  #
  # Returns:
  # - boundingbox: a BoundingBox object if successful
  #

  # Test the example code that we have in the API documentation.
  def test_new_api_example 
    assert_nothing_raised do
     boundbox = Geom::BoundingBox.new
    end
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.add
  # @file                rboundingbox.cpp
  #
  # The add method is used to add a point, or other bounding boxes, to the
  # bounding box. The size of the bounding box will increase as necessary
  # to accommodate the new points or bounding boxes.
  #
  # Adding one point to an empty bounding box, does not increase the size
  # of the bounding box. You must add at least two points before methods,
  # such as BoundingBox.diagonal, will return a size greater than zero.
  #
  #
  # Args:
  # - points_or_bb: A list or single instance or Point3d or BoundingBox
  # objects
  #
  # Returns:
  # - boundingbox: the new, resized, BoundingBox object if
  # successful
  #

  # Test the example code that we have in the API documentation.
  def test_add_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     bbox = model.bounds
     point1 = Geom::Point3d.new(100, 200, 300)
     bbox = bbox.add point1
    end
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.width
  # @file                rboundingbox.cpp
  #
  # The width method is used to retrieve the width of the bounding box.
  #
  # The width is returned in the currently set units (inches, by
  # default).
  #
  #
  # Args:
  #
  # Returns:
  # - width: the width of the bounding box
  #

  # Test the example code that we have in the API documentation.
  def test_width_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     bbox = model.bounds
     point1 = Geom::Point3d.new(100, 200, 300)
     point2 = Geom::Point3d.new(300, 200, 100)
     bbox = bbox.add point1
     bbox = bbox.add point2
     UI.messagebox(bbox.width)
    end
  end

  # Test some controlled BBs.
  def test_width_simple
    bbox = nil
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox = bbox.add [100,100,100]
     bbox = bbox.add [200,200,200]
    end
    assert_equal(100, bbox.width,
                 'Failed in test_width_simple' )
  end

  # Test a zero-width BB.
  def test_width_zero
    bbox = nil
    assert_nothing_raised do
     bbox = Geom::BoundingBox.new
     bbox = bbox.add [100,100,100]
     bbox = bbox.add [100,200,200]
    end
    assert_equal(0, bbox.width,
                 'Failed in test_width_zero' )
  end



  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.diagonal
  # @file                rboundingbox.cpp
  #
  # The diagonal method is used to get the length of the diagonal of the
  # bounding box.
  #
  # The diagonal is returned in the currently set units (inches, by
  # default).
  #
  #
  # Args:
  #
  # Returns:
  # - diagonal: the size of the diagonal for the bounding
  # box if successful
  #

  # Test the example code that we have in the API documentation.
  def test_diagonal_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     bbox = model.bounds
     point1 = Geom::Point3d.new(100, 200, 300)
     point2 = Geom::Point3d.new(300, 200, 100)
     bbox = bbox.add point1
     bbox = bbox.add point2
     UI.messagebox(bbox.diagonal)
    end
  end

  def test_diagonal_known_case
    bbox = Geom::BoundingBox.new
    bbox = bbox.add [0,0,0]
    bbox = bbox.add [10,10,10]
    assert_equal(17.3205080756888.to_l, bbox.diagonal,
                 'Failed in test_diagonal_known_case')
  end

  def test_diagonal_negative_position
    bbox = Geom::BoundingBox.new
    bbox = bbox.add [0,0,0]
    bbox = bbox.add [-10,-10,-10]
    assert_equal(17.3205080756888.to_l, bbox.diagonal,
                 'Failed in test_diagonal_negative_position')
  end

  def test_diagonal_mixed_position
    bbox = Geom::BoundingBox.new
    bbox = bbox.add [-5,-5,-5]
    bbox = bbox.add [5,5,5]
    assert_equal(17.3205080756888.to_l, bbox.diagonal,
                 'Failed in test_diagonal_mixed_position')
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    BoundingBox.center
  # @file                rboundingbox.cpp
  #
  # The center method is used to retrieve the Point3d object at the center
  # of the bounding box.
  #
  #
  # Args:
  #
  # Returns:
  # - point: the Point3d at the center of the bounding box
  # if successful
  #

  # Test the example code that we have in the API documentation.
  def test_center_api_example
    assert_nothing_raised do
     # There will not be any size to your bounding box until you add at least
     # two points prior to calling model.bounds
     boundbox = Sketchup.active_model.bounds
     center = boundbox.center
     UI.messagebox center
    end
  end

  def test_center_known_case
    bbox = Geom::BoundingBox.new
    bbox = bbox.add [0,0,0]
    bbox = bbox.add [10,10,10]
    assert_equal(Geom::Point3d.new(5,5,5), bbox.center,
                 'Failed in test_center_known_case')
  end

  def test_center_negative_position
    bbox = Geom::BoundingBox.new
    bbox = bbox.add [0,0,0]
    bbox = bbox.add [-10,-10,-10]
    assert_equal(Geom::Point3d.new(-5,-5,-5), bbox.center,
                 'Failed in test_center_negative_position')
  end

  def test_center_origin_position
    bbox = Geom::BoundingBox.new
    bbox = bbox.add [-5,-5,-5]
    bbox = bbox.add [5,5,5]
    assert_equal(Geom::Point3d.new(0,0,0), bbox.center,
                 'Failed in test_center_origin_position')
  end

end
