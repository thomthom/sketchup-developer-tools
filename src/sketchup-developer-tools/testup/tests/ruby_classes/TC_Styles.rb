# Copyright:: Copyright 2012 Trimble Navigation Ltd.
# License:: Apache License version 2.0
# Original Author:: Scott Lininger 
# Author: Simone Nicolo 
# Tests the SketchUp Ruby API Styles object.
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

# TC_Styles contains unit tests for the Styles class.
#
# API Object::       Styles
# C++ File::         rstyle.cpp
# Parent Class::     Object
# Version::          SketchUp 6.0
#
# The Styles class contains methods for manipulating a collection of styles in
# a model. Typically, you will access this via the active_model:
class TC_Styles < Test::Unit::TestCase

  # Setup for test cases, if required.
  #
  def setup
    def UI::messagebox(params)
      puts 'TESTUP OVERRIDE: UI::messagebox > ' + params.to_s
    end
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.each
  # @file                rstyle.cpp
  #
  # The each method is used to iterate through styles.
  #
  #
  # Args:
  # - style: Variable that will hold each style as it is found.
  #
  # Returns:
  # - : nil
  #

  # Test the example code that we have in the API documentation.
  def test_each_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
      styles.each {| style |
        UI.messagebox('style: ' + style.name)
     }
    end
  end

#  # Test edgecases for values passed to this method.
#  def test_each_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_each_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_each_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # Test that the number of iterations is equal to the reported length.
  def test_each_iterations_matches_length
    collection = Sketchup.active_model.styles
    count = 0
    collection.each do |obj|
      count = count + 1
    end
    expected = collection.size
    result = count
    assert_equal(expected, result,
                 'Failed in test_each_iterations_matches_length.')
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.selected_style
  # @file                rstyle.cpp
  #
  # The selected_style method is used to retrieve the currently selected
  # style.
  #
  #
  # Args:
  #
  # Returns:
  # - style: the selected Style object.
  #

  # Test the example code that we have in the API documentation.
  def test_selected_style_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
      style = styles.selected_style
      UI.messagebox('the selected style is: ' + style.name)
    end
  end

#  # Test edgecases for values passed to this method.
#  def test_selected_style_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_selected_style_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_selected_style_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.purge_unused
  # @file                rstyle.cpp
  #
  # The purge_unused method is used to remove unused styles from the
  # model.
  #
  #
  # Args:
  #
  # Returns:
  # - status: true if successful, false if unsuccessful.
  #

  # Test the example code that we have in the API documentation.
  def test_purge_unused_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
      status = styles.purge_unused
      UI.messagebox('Purging Unused styles status: ' + status.to_s)
    end
  end

#  # Test edgecases for values passed to this method.
#  def test_purge_unused_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_purge_unused_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_purge_unused_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.parent
  # @file                rstyle.cpp
  #
  # The parent method is used to determine the model for the styles.
  #
  #
  # Args:
  #
  # Returns:
  # - model: the model that contains the styles if
  # successful
  #

  # Test the example code that we have in the API documentation.
  def test_parent_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
     model = styles.parent
     UI.messagebox('The current Model ID is: ' + model.to_s)
    end
  end

#  # Test edgecases for values passed to this method.
#  def test_parent_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_parent_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_parent_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.update_selected_style
  # @file                rstyle.cpp
  #
  # The update_selected_style method returns true if the selected style
  # was changed (e.g. the user selected a different style).
  #
  #
  # Args:
  #
  # Returns:
  # - : true if successful
  #

  # Test the example code that we have in the API documentation.
  def test_update_selected_style_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
      success = styles.update_selected_style
      UI.messagebox('The selected style was updated: ' + success.to_s)
    end
  end

#  # Test edgecases for values passed to this method.
#  def test_update_selected_style_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_update_selected_style_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_update_selected_style_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.size
  # @file                rstyle.cpp
  #
  # The size method is used to retrieve the number of styles in the
  # collection. This is an alias for the Styles.count method.
  #
  #
  # Args:
  #
  # Returns:
  # - size: the number of styles found.
  #

  # Test the example code that we have in the API documentation.
  def test_size_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
      how_many = styles.size
      UI.messagebox('The in model styles are ' + how_many.to_s)
    end
  end

  # Test edgecases for values passed to this method.
  def test_size_edgecases
    styles = Sketchup.active_model.styles
    assert_equal(styles.count, styles.size,
                 'Failed in test_size_edgecases' )
  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_size_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.add_style
  # @file                rstyle.cpp
  #
  # The add_style method is used to create and load a style from the given
  # file.
  #
  #
  # Args:
  # - filename: The filename for the style.
  # - select: true if you want to set the style to be the active style,
  # false if not.
  #
  # Returns:
  # - status: true if successful, false if unsuccessful.
  #

  # Test the example code that we have in the API documentation.
  def test_add_style_api_example
    styles = Sketchup.active_model.styles
    status = false
    assert_nothing_raised do
      status = styles.add_style "c:\\MyStyle.style", true
    end
    UI.messagebox('A style was added: ' + status.to_s)
  end

#  # Test edgecases for values passed to this method.
#  def test_add_style_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_add_style_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_add_style_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.active_style_changed
  # @file                rstyle.cpp
  #
  # The active_style_changed method tells you if the active style has been
  # edited by the user in any way since it was last saved.
  #
  #
  # Args:
  #
  # Returns:
  # - : true if the active style has been changed from
  # when it was last saved.
  #

  # Test the example code that we have in the API documentation.
  def test_active_style_changed_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
      user_made_change = styles.active_style_changed
      UI.messagebox('The active style was edited: ' + user_made_change.to_s)
    end
    end

#  # Test edgecases for values passed to this method.
#  def test_active_style_changed_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_active_style_changed_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_active_style_changed_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.[]
  # @file                rstyle.cpp
  #
  # The [] method is used to retrieves a style by either name or index.
  #
  #
  # Args:
  # - name_or_index: The string name or index for a specific style.
  #
  # Returns:
  # - style: a Style object if successful
  #

  # Test the example code that we have in the API documentation.
  def test_arrayget_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
      style1 = styles[0]
      style2 = styles["name"]
    end
  end

#  # Test edgecases for values passed to this method.
#  def test_arrayget_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_arrayget_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_arrayget_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

#  # Test that nil is returned if there is a negative index requested.
#  def test_arrayget_nil_on_negative_index
#    collection = Sketchup.active_model.styles
#    expected = nil
#    result = collection[-1]
#    assert_equal(expected, result,
#                 'Expected does not match result.')
#  end

#  # Test that nil is returned if there is a non-existent index requested.
#  # We use the length of the collection to our non-existent index.
#  def test_arrayget_nil_on_nonexistent_index
#    collection = Sketchup.active_model.styles
#    expected = nil
#    result = collection[collection.length]
#    assert_equal(expected, result,
#                 'Expected does not match result.')
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.count
  # @file                rstyle.cpp
  #
  # The count method is used to retrieve the number of styles in the
  # collection.
  #
  #
  # Args:
  #
  # Returns:
  # - count: the number of styles found.
  #

  # Test the example code that we have in the API documentation.
  def test_count_api_example
    assert_nothing_raised do
     styles = Sketchup.active_model.styles
     how_many = styles.count
     UI.messagebox('The in model styles are ' + how_many.to_s)
    end
  end

  # Test edgecases for values passed to this method.
  def test_count_edgecases
    styles = Sketchup.active_model.styles
    assert_equal(styles.size, styles.count,
                 'Failed in test_count_edgecases' )
  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_count_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.selected_style=
  # @file                rstyle.cpp
  #
  # The selected_style= method is used to set the currently selected
  # style.
  #
  #
  # Args:
  # - style: The style object to select.
  #
  # Returns:
  # - : false
  #

  # Test the example code that we have in the API documentation.
  def test_set_selected_style_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
      styles.selected_style = styles[styles.count - 1]
    end
  end

#  # Test edgecases for values passed to this method.
#  def test_set_selected_style_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_set_selected_style_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_set_selected_style_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    Styles.active_style
  # @file                rstyle.cpp
  #
  # The active_style method is used to retrieve the active style.
  #
  #
  # Args:
  #
  # Returns:
  # - style: the active Style object.
  #

  # Test the example code that we have in the API documentation.
  def test_active_style_api_example
    styles = Sketchup.active_model.styles
    assert_nothing_raised do
     active_style = styles.active_style
     UI.messagebox('The active style is: ' + active_style.name)
    end
  end

#  # Test edgecases for values passed to this method.
#  def test_active_style_edgecases
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_equal('expected', 'result',
#                 'Failed in test_active_style_edgecases' )
#  end

#  # Test what happens when bad arguments are passed (nil, too few, etc.)
#  def test_active_style_bad_params
#    raise('AUTOGENERATED STUB. Do manual review, then delete this warning.')
#    assert_raise RuntimeError do
#      # bad arguments here that should cause errors
#    end
#  end

end
