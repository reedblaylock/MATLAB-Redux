# MATLAB-Redux

Author: Reed Blaylock

## About MATLAB-Redux

If you're on this page, you're probably here to install this code as a prerequisite to the <a href="https://github.com/reedblaylock/VocalTract-ROI-Toolbox">VocalTract ROI Toolbox</a>. Skip down to "Installation" and don't worry about the details!

This program is a scaffolding for creating graphical user interfaces (GUIs) in MATLAB with a state-flow architecture inspired by <a href="https://redux.js.org/">Redux</a> (a popular JavaScript framework for uni-directional state management).

MATLAB-Redux wraps up GUI rendering and state management into one system:
- GUI creation is done with the GUI Layout Toolbox (Tordoff 2021 for <a href="https://www.mathworks.com/matlabcentral/fileexchange/47982-gui-layout-toolbox">R2014a and earlier</a>, Sampson 2021 for <a href="https://www.mathworks.com/matlabcentral/fileexchange/47982-gui-layout-toolbox">R2014b and later</a) to ensure that GUIs are flexible, resizable, and highly customizable.
- The application's state is defined on the fly by a set of functions ("reducers") that respond to events from interaction with the GUI ("actions"). It's flexible, and ideally less bug-prone than applications with always-available global state

## Installation

This code runs in MATLAB. It was tested on versions R2014b and R2020a, but should work well enough on any version after R2010b.

Installation is a 3-step process:

1. Download this code as a .zip file by clicking the green "Clone or download" button above
2. Unzip/extract the files you just downloaded into a new folder
3. Open MATLAB and add the folder you just created *and its subfolders* to your MATLAB path

That's it!

## How to use this toolbox

MATLAB-Redux doesn't do much on its own. The expected use case is to use it with tools like the <a href="https://github.com/reedblaylock/VocalTract-ROI-Toolbox">VocalTract ROI Toolbox</a>.

If you want to use MATLAB-Redux to make your own GUI, start by looking at these files from the <a href="https://github.com/reedblaylock/VocalTract-ROI-Toolbox">VocalTract ROI Toolbox</a>:

- `+vt/init.m` demonstrates how to initialize an application
- `+vt/App.m` shows an example of programmatically assembling a GUI

The template `App.txt` in this package can be renamed to `App.m` and used as the base for your new application.

To make sure that MATLAB doesn't get confused, keep any new applications you build in a separate namespace. The MATLAB-Redux namespace is `+redux`, and the <a href="https://github.com/reedblaylock/VocalTract-ROI-Toolbox">VocalTract ROI Toolbox</a> namespace is `+vt`. To make a new namespace for your application, create a new folder for your application somewhere outside the `+redux` folder and name it with a plus at the beginning (i.e., `+[your application name]`).

## References
- David Sampson (2021). GUI Layout Toolbox (https://www.mathworks.com/matlabcentral/fileexchange/47982-gui-layout-toolbox), MATLAB Central File Exchange. Retrieved July 23, 2021.
- Ben Tordoff (2021). GUI Layout Toolbox (https://www.mathworks.com/matlabcentral/fileexchange/27758-gui-layout-toolbox), MATLAB Central File Exchange. Retrieved July 23, 2021.