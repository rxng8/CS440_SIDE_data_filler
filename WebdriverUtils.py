import time
import os
import sys

from selenium import webdriver
from selenium.webdriver.remote.webdriver import WebDriver as RemoteWebDriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select

def create_webdriver(test_name, automated_path, chrome_driver_path="chromedriver.exe"):
    driver = webdriver.Chrome(chrome_driver_path)
    # driver.maximize_window()

    time.sleep(3)
    driver.get(os.getenv('automation', automated_path))

    return driver