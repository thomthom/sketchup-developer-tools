# Copyright:: Copyright 2012 Trimble Navigation Ltd.
# License:: Apache License version 2.0
# Original Author:: Scott Lininger 
#
# Tests the SketchUp Ruby API AttributeDictionaries object.
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

# TC_AttributeDictionaries contains unit tests for the AttributeDictionaries class.
#
# API Object::       AttributeDictionaries
# C++ File::         rattributecontainer.cpp
# Parent Class::     Object
# Version::          SketchUp 6.0
#
# The AttributeDictionaries class is a collection of all of the
# AttributeDictionary objects that are attached to a given Entity object.
#
#
class TC_AttributeDictionaries < Test::Unit::TestCase

  # Setup for test cases, if required.
  #
  def setup
    def UI::messagebox(params)
      puts 'TESTUP OVERRIDE: UI::messagebox > ' + params.to_s
    end
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    AttributeDictionaries.delete
  # @file                rattributecontainer.cpp
  #
  # Get an AttributeDictionary by name. Returns nil if there is none with
  # the given name.
  #
  #
  # Args:
  # - key_or_dict: The name of the attribute dictionary to delete, or the
  # dictionary object itself.
  #
  # Returns:
  # - dictionaries: the modified AttributeDictionaries object
  #

  # Test the example code that we have in the API documentation.
  def test_delete_api_example
    attrdicts = nil
    assert_nothing_raised do
     model = Sketchup.active_model
     attrdicts = model.attribute_dictionaries
     # Deletes a dictionary called 'my_dictionary'
     attrdicts.delete 'my_dictionary'
    end
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    AttributeDictionaries.[]
  # @file                rattributecontainer.cpp
  #
  # Get an AttributeDictionary by name. Returns nil if there is none with
  # the given name.
  #
  #
  # Args:
  # - key: The name of the attribute dictionary.
  #
  # Returns:
  # - dictionary: the dictionary
  #

  # Test the example code that we have in the API documentation.
  def test_arrayget_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     attrdicts = model.attribute_dictionaries
     # Iterates through all dictionaries and prints to screen.
     dict = attrdicts['my_dictionary']
     if dict
       UI.messagebox("Found: " + dict.to_s)
     else
       UI.messagebox("No dictionary found.")
     end
    end
  end

  # Test that nil is returned if there is a empty string index requested.
  def test_arrayget_nil_on_negative_index
    collection = Sketchup.active_model.attribute_dictionaries
    expected = nil
    result = collection['']
    assert_equal(expected, result,
                 'Expected does not match result.')
  end

  # Test that nil is returned if there is a non-existent index requested.
  # We use the length of the collection to our non-existent index.
  def test_arrayget_nil_on_nonexistent_index
    collection = Sketchup.active_model.attribute_dictionaries
    expected = nil
    result = collection['some_nonexistent_key']
    assert_equal(expected, result,
                 'Expected does not match result.')
  end

  # ----------------------------------------------------------------------------
  # @par Ruby Method:    AttributeDictionaries.each
  # @file                rattributecontainer.cpp
  #
  # The each method is used to iterate through all of the attributes
  # dictionaries.
  #
  # Throws an exception if there are no keys.
  #
  #
  # Args:
  # - dict: Each AttributeDictionary as it is found.
  #
  # Returns:
  # - : nil
  #

  # Test the example code that we have in the API documentation.
  def test_each_api_example
    assert_nothing_raised do
     model = Sketchup.active_model
     attrdicts = model.attribute_dictionaries
     # Iterates through all dictionaries and prints to screen.
     attrdicts.each { | dict | UI.messagebox dict }
    end
  end

end
