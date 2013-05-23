require 'test_helper'
require 'digest/md5'

class TranslationsTest < ActionDispatch::IntegrationTest

  setup do
    Capybara.current_driver = Capybara.javascript_driver
  end


  test "load translations" do
    visit '/'
    within("h1") do
      assert page.has_content? 'Translations'
    end

  end


  test "create a translation" do
    visit '/'
    click_link 'add-translation-link'
    find("#add-translation").visible?

    within('#form-translation') do
      fill_in 'locale', with: 'en'
      fill_in 'key', with: 'test.dog'
      fill_in 'value', with: 'dog'
      click_button 'Submit'
    end

    digest = digest_key('test.dog')

    assert_no_selector("#add-translation")
    assert page.has_css?("#translation_key_#{digest}")
    within("#translation_key_#{digest}") do
      assert page.has_content? 'test.dog'
      assert page.has_content? 'dog'
    end

    I18nDashboard::Translation.destroy(digest)
  end


  test "edit a translation" do
    digest = I18nDashboard::Translation.create('test.dog', 'dog', 'en')

    visit '/'

    within("#translation_key_#{digest}") do
      click_link 'en.test.dog'
    end

    find("#add-translation").visible?
    within('#form-translation') do
      assert page.has_field? 'locale', with: 'en'
      assert page.has_field? 'key', with: 'test.dog'
      assert page.has_field? 'value', with: 'dog'

      fill_in 'value', with: 'the dog'
      click_button 'Submit'
    end

    assert_no_selector("#add-translation")
    assert page.has_css?("#translation_key_#{digest}")
    within("#translation_key_#{digest}") do
      assert page.has_content? 'test.dog'
      assert page.has_content? 'the dog'
    end

    I18nDashboard::Translation.destroy(digest)
  end

  test "destroy a translation" do
    digest = I18nDashboard::Translation.create('test.dog', 'dog', 'en')
    assert page.has_css?("#translation_key_#{digest}")
    click_link "destroy-#{digest}"
    I18nDashboard::Translation.destroy(digest)
  end

  test "search keys" do
    I18nDashboard::Translation.create('test.dog', 'dog', 'en')
    I18nDashboard::Translation.create('test.house', 'house', 'en')
    I18nDashboard::Translation.create('test.chair', 'chair', 'en')
    visit '/'

    within('#search-form') do
      fill_in 'query', with: 'o'
      click_button 'search'
      assert page.has_field? 'query', with: 'o'
    end

    within("#translation_key_#{digest_key('test.dog')}") do
      assert page.has_content? 'test.dog'
      assert page.has_content? 'dog'
    end

    within("#translation_key_#{digest_key('test.house')}") do
      assert page.has_content? 'test.house'
      assert page.has_content? 'house'
    end

    assert_no_selector("#translation_key_#{digest_key('test.chair')}")
  end


  def digest_key(key)
    Digest::MD5.hexdigest(key)
  end
end
