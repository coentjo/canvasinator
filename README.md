# canvasinator

A side kick for https://github.com/coentjo/GlamorousAdventures  

-inator for DLWO Canvas

Just playing around creating tools for use in GToolkit. 

# Load it in GToolkit

Execute in a Playground 

```
Metacello new
    baseline: 'Canvasinator';
    repository: 'github://coentjo/canvasinator:main/src';
    onConflictUseIncoming;
    load.
#BaselineOfCanvasinator  asClass loadLepiter
```

# Instructions

To see a Canvasinator example: inspect this: 

```
CACanvasCourse 
	courseId: 15726 
	fromSnippet: thisSnippet
```
(works for the https://fhict.instructure.com/ realm... )


Get a canvas token here:
- clock on your profile photo (left, up above)
- 'Settings'
- Scroll down all the way to the Button 'New Access Token'

This token needs to be put into: 

```
FileLocator home / 'tokens' / 'token_canvas.txt'
```

