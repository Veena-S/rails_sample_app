require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get home" do
    get root_path
    assert_response :success
    # the assert_select method lets us test for the presence of a particular HTML tag
    assert_select "title", "#{@base_title}"

  end

  test "should get help" do
    get help_path
    # get helf_path # if the alias is specified as "helf"
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
