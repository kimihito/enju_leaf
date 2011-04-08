# -*- encoding: utf-8 -*-
require 'test_helper'

class ManifestationTest < ActiveSupport::TestCase
  fixtures :manifestations, :items,
    :reserves, :users, :roles, :languages, :realizes, :creates, :produces,
    :frequencies, :form_of_works, :content_types, :carrier_types, :countries, :patron_types,
    :answer_has_items

  def test_sru_search 
    sru = Sru.new({:query => "title=Ruby"})
    sru.search
    assert_equal 18, sru.manifestations.size
    assert_equal 'Ruby', sru.manifestations.first.titles.first
    sru = Sru.new({:query => "title=^ruby"})
    sru.search
    assert_equal 9, sru.manifestations.size
    sru = Sru.new({:query => 'title ALL "awk sed"'})
    sru.search
    assert_equal 2, sru.manifestations.size
    assert_equal [184, 116], sru.manifestations.collect{|m| m.id}
    sru = Sru.new({:query => 'title ANY "ruby awk sed"'})
    sru.search
    assert_equal 22, sru.manifestations.size
    sru = Sru.new({:query => 'isbn=9784756137470'})
    sru.search
    assert_equal 114, sru.manifestations.first.id
    sru = Sru.new({:query => "creator=テスト"})
    sru.search
    assert_equal 1, sru.manifestations.size
  end

  def test_sru_search_date
    sru = Sru.new({:query => "from = 2000-09 AND until = 2000-11-01"})
    sru.search
    assert_equal 1, sru.manifestations.size
    assert_equal 120, sru.manifestations.first.id
    sru = Sru.new({:query => "from = 1993-02-24"})
    sru.search
    assert_equal 5, sru.manifestations.size    
    sru = Sru.new({:query => "until = 2006-08-06"})
    sru.search
    assert_equal 4, sru.manifestations.size
  end

  def test_sru_search_relation
    sru = Sru.new({:query => "from = 1993-02-24 AND until = 2006-08-06 AND title=プログラミング"})
    sru.search
    assert_equal 2, sru.manifestations.size
    sru = Sru.new({:query => "until = 2000 AND title=プログラミング"})
    sru.search
    assert_equal 1, sru.manifestations.size
    sru = Sru.new({:query => "from = 2006 AND title=プログラミング"})
    sru.search
    assert_equal 1, sru.manifestations.size
    sru = Sru.new({:query => "from = 2007 OR title=awk"})
    sru.search
    assert_equal 6, sru.manifestations.size
  end

  def test_reserved
    assert manifestations(:manifestation_00007).is_reserved_by(users(:admin))
  end

  def test_not_reserved
    assert_nil manifestations(:manifestation_00007).is_reserved_by(users(:user1))
  end

  def test_manifestation_should_show_languages
    assert manifestations(:manifestation_00001).language
  end

  #def test_manifestation_should_show_oai_dc
  #  assert manifestations(:manifestation_00001).to_oai_dc
  #end

  def test_manifestation_should_get_number_of_pages
    assert_equal 100, manifestations(:manifestation_00001).number_of_pages
  end

  def test_manifestation_should_import_isbn
    assert Manifestation.import_isbn('4797327030')
  end

  def test_youtube_id
    assert_equal manifestations(:manifestation_00022).youtube_id, 'BSHBzd9ftDE'
  end

  def test_nicovideo_id
    assert_equal manifestations(:manifestation_00023).nicovideo_id, 'sm3015373'
  end

  def test_manifestation_should_respond_to_pickup
    assert Manifestation.pickup
  end

  def test_manifestation_should_respond_to_title
    assert manifestations(:manifestation_00001).title
  end

  def test_manifestation_should_have_screen_shot
    assert manifestations(:manifestation_00003).screen_shot
  end

  def test_manifestation_should_not_have_parent_of_series
    assert manifestations(:manifestation_00001).parent_of_series
  end

  def test_manifestation_should_response_to_extract_text
    assert_nil manifestations(:manifestation_00001).extract_text
  end

  def test_manifestation_should_not_be_reserved_if_it_has_no_item
    assert_equal false, manifestations(:manifestation_00008).reservable?
  end

end
