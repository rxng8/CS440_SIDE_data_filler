# Filler Engine for tagged SIDE Script

## Test pages

https://hopeful-bartik-dccd71.netlify.app/index1.html

https://hopeful-bartik-dccd71.netlify.app/index2.html

https://hopeful-bartik-dccd71.netlify.app/index3.html

https://hopeful-bartik-dccd71.netlify.app/index4.html

https://hopeful-bartik-dccd71.netlify.app/index5.html

https://hopeful-bartik-dccd71.netlify.app/index6.html

https://hopeful-bartik-dccd71.netlify.app/index7a.html

https://hopeful-bartik-dccd71.netlify.app/index7b.html

------------
## Run
1. Run the filler to fill all the tags in the selenium script specifying the selenium script and the application json data file
```
python am_filler.py side.generated/checkbox.side data/a1.json
```

2. The generated/filled will be placed in `outputs` folder:

3. Test running the filled SIDE script:
```
python selenium_runner.py outputs/result.side
# or
selenium-side-runner outputs/result.side
```