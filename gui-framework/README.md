# Introduction

**GUI Framework** is a scripting library written in squirrel for **[Gothic 2 Online](http://gothic-online.com.pl/)** mod. \
It allows you to create Graphical User Interface Elements like Buttons, Bars, Windows, and many others. \
The idea behind the framework is very simple, allows anyone, who want to use it, to desing an GUI interface, \
for your needs, not creating another framework by your own.

If you're interested in using, you can simply analize the code examples, how you can create specific elements, and \
use them in some way. Every element does have a simple example.

# Installation

## First step

### Classic

If you're interested in using this framework, you can download the copy of the repository, just simply click, on \
download button and choose the archive type to download, for example: .zip. \
After downloading the framework, just extract the files into your server folder, anywhere you like.

### Git

If you know **git**, you can clone the repository into your server folder anywhere you like. This way, you can always easily make a pull \
when new commit(s) will be pushed into remote repo, so it's very practical, if you want to be up to date.

## Second step

Now, you have to include the all scripts to your project, this can be done, by adding this line \
to your .xml file, this can be, for example, ``config.xml``.

**NOTE!** \
Make sure, that name of the folder in src attribute does match with yours.

```xml
<import src="gui-framework/gui.xml" />
```

# Contributing

You can always contribute to the development of this project, by creating **[issues](https://gitlab.com/g2o/scripts/gui-framework/issues)**. \
If you're interested in development of the framework, you can always make a fork of this repository, and make a merge request, which \
we will discuss.

# License 

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
