# Install Required Tools


## Python

* Download __Python 2.7.x (32 bit)__ executable (msi) installer from [python.org](https://www.python.org/downloads/release)
* Place the file in C:\HashiCorp and run with all defaults. (Create this directory, if necessary)
* Verify python/pip are installed:
```
> pip --version
pip 9.0.1 from c:\python27\lib\site-packages (python 2.7)

> python
Python 2.7.14 (v2.7.14:84471935ed, Sep 16 2017, 20:19:30) [MSC v.1500 32 bit (Intel)] on win32
Type "help", "copyright", "credits" or "license" for more information.
>>>
```
Type to exit:
```
>>> exit()
```
* Note: if these commands return error message like
```
'python' is not recognized as an internal or external command,
operable program or batch file.
```
- add "C:\Python27;C:\Python27\Scripts;" to you user or system PATH environment variable, 
- Restart Windows (for system env variable to come in effect)
- retry running commands above


## Robot Framework (RF)
```
> pip install --trusted-host pypi.python.org robotframework
```
Verify:
```
> robot --version
Robot Framework 3.0.2 (Python 2.7.14 on win32)
> rebot --version
Rebot 3.0.2 (Python 2.7.14 on win32)
```

#### RF Selenium library
```
> pip install --trusted-host pypi.python.org --pre robotframework-seleniumlibrary
```

#### RF Http API libraries
```
> pip install --trusted-host pypi.python.org requests
> pip install --trusted-host pypi.python.org robotframework-requests
> pip install --trusted-host pypi.python.org robotframework-jsonlibrary
```

#### RF Code Check library
```
> pip install --trusted-host pypi.python.org robotframework-lint
```

## Chrome Driver
* Download latest chromedriver_win32.zip for example [cromedriver v 2.36](https://chromedriver.storage.googleapis.com/index.html?path=2.36/)
* Unzip to any non-user _location_ (e.g. C:\Support)
* update Windows *System* PATH environment variable with the new _location_
* Restart Windows (for system env variable to come in effect)


## Git (skip if already installed)
* Download _Windows_ version from https://git-scm.com/download
* Place in C:\HashiCorp
* Run with defaults except for:
	(important!) select "Use the native Windows Secure Channel library" option
* Verify:
```
> git --version
git version 2.14.1.windows.1
```

## Verify all required tools installed correctly
* Checkout Test Automation project from Git:
``` 
> git clone https://<robot-project>.git 
> cd robot-tests
```
* Follow instructions in README.md to run automated (smoke) tests

_Note_:
In at least one instance on Windows 10 was unable to link _Robot Framework_ to _chromedriver_ by PATH environment variable  with error:
```
WindowsError: [Error 87] The parameter is incorrect
```
If you experience this error please try to move the __cromedriver.exe__ from _C:\Support_ to _C:\Windows\System_ (where Windows can find/launch it by default)

## UI tools (power users may want to skip)

### RIDE (Robot Framework editor)

#### wxPython (32 bit version)
* Download wxPython2.8-win32-unicode-2.8.12.1-py27.exe from [sourceforge.net](https://sourceforge.net/projects/wxpython/files/wxPython/2.8.12.1/)
* Place the file in C:\HashiCorp and run with all defaults

#### robotframework-ride
```
> pip install --trusted-host pypi.python.org robotframework-ride
```

* Run RIDE 
```
> ride.py
```
* or (if restricted):
```
> cd C:\Python27\Scripts 
> python ride.py
```

### SourceTree (UI for Git)
* Download SourceTree from https://www.sourcetreeapp.com/
* Place the file in C:\HashiCorp and run with all defaults
* Setup an Atlassian account as required
* Finish install