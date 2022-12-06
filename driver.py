from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
from selenium import webdriver
from bs4 import BeautifulSoup as bs


class WebDriver:
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))

    def renderPage(self, url: str):
        self.driver.get(url)
        rendered_page = self.driver.page_source
        soup = bs(rendered_page, "html.parser").body
        return soup
