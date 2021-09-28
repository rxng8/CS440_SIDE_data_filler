import WebdriverUtils
import time
import sys
import os
import json

if __name__ == "__main__":

    print("Running a file...")
    # side_file_path = sys.argv[1]
    # generated_side = json.load(open(side_file_path))

    # assert generated_side["tests"][0]["commands"][0]["command"] == "open", print("Behavior not expected!")
    # web_path = generated_side["url"] + generated_side["tests"][0]["commands"][0]["target"]
    # driver = WebdriverUtils.create_webdriver("selenium_runner.py", web_path)

    try:
        os.system("selenium-side-runner " + side_file_path)
    except Exception as ex:
        print(ex)
        driver.quit()
        sys.exit(-1)
    else:
        print(" was successful.")
        driver.quit()