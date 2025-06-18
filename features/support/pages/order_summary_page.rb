class OrderSummaryPage < BasePage
  include Capybara::DSL

  TITLE = '.header_secondary_container > span.title'.freeze
  PRODUCT_ROW = '.cart_item'
  PRODUCT_NAME = '.inventory_item_name'
  DESCRIPTION = '.inventory_item_desc'
  PRICE = '.inventory_item_price'
  QUANTITY = '.cart_quantity'
  DATA_TEST_SELECTOR = '[data-test="%s"]'
  SUMMARY_LABEL = '.summary_%s_label'
  SUMMARY_VALUES = '.summary_value_label'
  FINISH_BUTTON = 'button[data-test="finish"]'
  CANCEL_BUTTON = 'button[data-test="cancel"]'
  COMPLETE_HEADER = '.complete-header'

  def on_page_with_title?(expected_title)
    has_css?(TITLE, text: expected_title)
  end

  def title_container_class_and_data_test
    title_element = find(TITLE)
    parent = title_element.find(:xpath, '..')
    { class: parent[:class], data_test: parent['data-test'] }
  end

  def inside_checkout_container?
    has_css?('#checkout_container')
  end

  def product_info
    row = find(PRODUCT_ROW)
    {
      quantity: row.find(QUANTITY).text,
      name: row.find(PRODUCT_NAME).text,
      description: row.find(DESCRIPTION).text,
      price: row.find(PRICE).text
    }
  end

  def product_name_is_link?
    has_css?(PRODUCT_NAME)
  end

  def product_container_class_and_data_test
    container = find(PRODUCT_ROW)
    { class: container[:class], data_test: container['data-test'] }
  end

  def payment_method
    all(SUMMARY_VALUES)[0].text
  end

  def shipping_method
    all(SUMMARY_VALUES)[1].text
  end

  def summary_label(type)
    find(SUMMARY_LABEL % type).text
  end

  def total_price
    find(SUMMARY_LABEL % 'total').text[/\d+\.\d+/].to_f
  end

  def click_button_by_text(text)
    click_button(text)
  end

  def has_button_with_text_and_data_test?(text, data_test)
    has_css?(DATA_TEST_SELECTOR % data_test, text: text)
  end

  def completion_message
    find(COMPLETE_HEADER).text
  end

  def all_data_test_elements_present?(table)
    table.all? do |row|
      has_css?(DATA_TEST_SELECTOR % row['Data-test'])
    end
  end

  def on_page_with_title?(txt)
    has_css?(TITLE, text: txt, wait: 5)
  end
end
