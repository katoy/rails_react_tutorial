# frozen_string_literal: true

module SystemHelpers
  SCRIPT_WIDTH =
    'return Math.max(' \
    'document.body.scrollWidth, ' \
    'document.body.offsetWidth, document.documentElement.clientWidth, ' \
    'document.documentElement.scrollWidth, ' \
    'document.documentElement.offsetWidth);'

  SCRIPT_HEIGHT =
    'return Math.max(' \
    'document.body.scrollHeight, ' \
    'document.body.offsetHeight, document.documentElement.clientHeight, ' \
    'document.documentElement.scrollHeight, ' \
    'document.documentElement.offsetHeight);'

  def take_full_page_screenshot(path)
    window = Capybara.current_session.driver.browser.manage.window

    width = 100 + Capybara.page.execute_script(SCRIPT_WIDTH)
    height = 100 + Capybara.page.execute_script(SCRIPT_HEIGHT)
    window.resize_to width, height
    page.save_screenshot path
  end
end
